import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

import '../../../const/env_config.dart';
import '../../../shared/themes/app_colors.dart';
import '../../../shared/themes/app_text_style.dart';
import '../data/model/geo_layer_model.dart';
import '../domain/map_state.dart';
import 'map_provider.dart';
import 'widgets/map_control_buttons.dart';
import 'widgets/map_popup_sheet.dart';

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  MapLibreMapController? _mapController;
  bool _isLocating = false;
  bool _isStyleLoaded = false;
  final List<Symbol> _currentSymbols = [];

  // Default initial camera position: Yogyakarta center
  static const CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(-7.799231, 110.368369),
    zoom: 13.0,
  );

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  void _onMapCreated(MapLibreMapController controller) {
    _mapController = controller;
    _mapController!.onSymbolTapped.add(_onSymbolTapped);
  }

  Future<void> _onStyleLoaded() async {
    _isStyleLoaded = true;
    ref.read(mapProvider.notifier).setMapReady(true);

    try {
      final ByteData byteData =
          await rootBundle.load('assets/image/marker_poi.png');
      final Uint8List bytes = byteData.buffer.asUint8List();
      await _mapController?.addImage('poi-pin', bytes);
    } catch (e) {
      debugPrint('Error loading poi-pin image: $e');
    }

    _syncLayerSymbols();
  }

  void _onSymbolTapped(Symbol symbol) {
    final state = ref.read(mapProvider);
    final features = state.features;

    // Find feature matching the tapped symbol
    GeoFeature? matchedFeature;
    if (symbol.data != null && symbol.data is Map) {
      try {
        matchedFeature = GeoFeature.fromJson(
          Map<String, dynamic>.from(symbol.data as Map),
        );
      } catch (_) {}
    }

    if (matchedFeature == null && symbol.options.geometry != null) {
      for (final f in features) {
        if ((f.latitude - symbol.options.geometry!.latitude).abs() < 0.0001 &&
            (f.longitude - symbol.options.geometry!.longitude).abs() < 0.0001) {
          matchedFeature = f;
          break;
        }
      }
    }

    if (matchedFeature != null) {
      ref.read(mapProvider.notifier).selectFeature(matchedFeature);
      _mapController?.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(matchedFeature.latitude, matchedFeature.longitude),
        ),
      );
    }
  }

  Future<void> _syncLayerSymbols() async {
    if (_mapController == null || !_isStyleLoaded) return;

    final state = ref.read(mapProvider);

    // Clear existing symbols
    for (final s in _currentSymbols) {
      await _mapController?.removeSymbol(s);
    }
    _currentSymbols.clear();

    if (!state.isLayerVisible || !state.hasFeatures) return;

    for (final feature in state.features) {
      if (feature.latitude == 0 && feature.longitude == 0) continue;

      final symbol = await _mapController?.addSymbol(
        SymbolOptions(
          geometry: LatLng(feature.latitude, feature.longitude),
          iconImage: 'poi-pin',
          iconSize: 0.6,
          iconAnchor: 'bottom',
          textField: feature.nama,
          textSize: 11.0,
          textColor: '#1A1A1A',
          textHaloColor: '#FFFFFF',
          textHaloWidth: 1.5,
          textOffset: const Offset(0, 1.2),
        ),
        feature.toJson(),
      );

      if (symbol != null) {
        _currentSymbols.add(symbol);
      }
    }
  }

  Future<void> _handleMyLocation() async {
    if (_isLocating) return;

    setState(() => _isLocating = true);

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Layanan lokasi (GPS) tidak aktif. Mohon aktifkan GPS.'),
              backgroundColor: Colors.orange,
            ),
          );
        }
        setState(() => _isLocating = false);
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Izin lokasi ditolak oleh pengguna.'),
                backgroundColor: Colors.redAccent,
              ),
            );
          }
          setState(() => _isLocating = false);
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Izin lokasi ditolak permanen. Buka Pengaturan untuk mengaktifkan.'),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
        setState(() => _isLocating = false);
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 10),
        ),
      );

      final userLatLng = LatLng(position.latitude, position.longitude);
      ref.read(mapProvider.notifier).setUserLocation(userLatLng);

      await _mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(userLatLng, 15.0),
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Lokasi Anda: ${position.latitude.toStringAsFixed(5)}, ${position.longitude.toStringAsFixed(5)}',
            ),
            duration: const Duration(seconds: 2),
            backgroundColor: AppColors.primaryColor,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal mengambil lokasi: $e'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLocating = false);
    }
  }

  void _recenterToJogja() {
    final state = ref.read(mapProvider);
    final features = state.features;

    if (features.isNotEmpty) {
      double minLat = features.first.latitude;
      double maxLat = features.first.latitude;
      double minLng = features.first.longitude;
      double maxLng = features.first.longitude;

      for (final f in features) {
        if (f.latitude < minLat) minLat = f.latitude;
        if (f.latitude > maxLat) maxLat = f.latitude;
        if (f.longitude < minLng) minLng = f.longitude;
        if (f.longitude > maxLng) maxLng = f.longitude;
      }

      _mapController?.animateCamera(
        CameraUpdate.newLatLngBounds(
          LatLngBounds(
            southwest: LatLng(minLat, minLng),
            northeast: LatLng(maxLat, maxLng),
          ),
          left: 60,
          top: 100,
          right: 60,
          bottom: 120,
        ),
      );
    } else {
      _mapController?.animateCamera(
        CameraUpdate.newCameraPosition(_initialCameraPosition),
      );
    }
  }

  void _toggleLayerVisibility() {
    ref.read(mapProvider.notifier).toggleLayerVisibility();
    _syncLayerSymbols();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(mapProvider);

    // Listen to layer data changes to re-sync symbols
    ref.listen<MapState>(mapProvider, (previous, next) {
      if (previous?.layerData != next.layerData ||
          previous?.isLayerVisible != next.isLayerVisible) {
        _syncLayerSymbols();
      }
    });

    return Scaffold(
      body: Stack(
        children: [
          // 1. MapLibre Map Base
          MapLibreMap(
            initialCameraPosition: _initialCameraPosition,
            styleString: EnvConfig.openFreeMapStyleUrl,
            onMapCreated: _onMapCreated,
            onStyleLoadedCallback: _onStyleLoaded,
            myLocationEnabled: true,
            myLocationRenderMode: MyLocationRenderMode.normal,
            myLocationTrackingMode: MyLocationTrackingMode.none,
            compassEnabled: true,
            attributionButtonMargins: const Point(10, 10),
            logoViewMargins: const Point(10, 10),
            onMapClick: (point, coordinates) {
              if (state.selectedFeature != null) {
                ref.read(mapProvider.notifier).selectFeature(null);
              }
            },
          ),

          // 2. Top Floating Header / Layer Info Card
          Positioned(
            top: MediaQuery.of(context).padding.top + 12.h,
            left: 16.w,
            right: 16.w,
            child: _buildTopHeader(state),
          ),

          // 3. Floating Control Action Buttons (Right Side)
          Positioned(
            right: 16.w,
            bottom: state.selectedFeature != null ? 240.h : 36.h,
            child: MapControlButtons(
              isLocating: _isLocating,
              isLayerVisible: state.isLayerVisible,
              onMyLocation: _handleMyLocation,
              onRecenterLayer: _recenterToJogja,
              onToggleLayer: _toggleLayerVisibility,
              onZoomIn: () => _mapController?.animateCamera(CameraUpdate.zoomIn()),
              onZoomOut: () =>
                  _mapController?.animateCamera(CameraUpdate.zoomOut()),
            ),
          ),

          // 4. Interactive Bottom Sheet for Selected Feature
          if (state.selectedFeature != null)
            Positioned(
              left: 0,
              right: 0,
              bottom: 16.h,
              child: MapPopupSheet(
                feature: state.selectedFeature!,
                onDismiss: () {
                  ref.read(mapProvider.notifier).selectFeature(null);
                },
                onFocus: () {
                  _mapController?.animateCamera(
                    CameraUpdate.newLatLngZoom(
                      LatLng(
                        state.selectedFeature!.latitude,
                        state.selectedFeature!.longitude,
                      ),
                      16.0,
                    ),
                  );
                },
              ),
            ),

          // 5. Global Loading Indicator for Layer Data
          if (state.isLoading)
            Positioned(
              top: MediaQuery.of(context).padding.top + 80.h,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.15),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 16.w,
                        height: 16.w,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation(AppColors.primaryColor),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        'Memuat data layer GEO MAPID...',
                        style: AppTextStyle.caption.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTopHeader(MapState state) {
    final layerName = state.layerData?.layerName ?? 'GEO MAPID';
    final featureCount = state.features.length;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: AppColors.borderCard),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              Icons.map_rounded,
              color: AppColors.primaryColor,
              size: 20.sp,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        layerName,
                        style: AppTextStyle.subtitle.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: state.isLayerVisible
                            ? Colors.green.withValues(alpha: 0.12)
                            : Colors.grey.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        state.isLayerVisible
                            ? '$featureCount POI'
                            : 'Disembunyikan',
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: state.isLayerVisible
                              ? Colors.green[800]
                              : Colors.grey[700],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                Text(
                  'OpenFreeMap Liberty • Basemap',
                  style: AppTextStyle.tiny.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.refresh_rounded,
              size: 20.sp,
              color: AppColors.primaryColor,
            ),
            tooltip: 'Muat Ulang Layer',
            onPressed: () {
              ref.read(mapProvider.notifier).fetchLayerData();
            },
          ),
        ],
      ),
    );
  }
}
