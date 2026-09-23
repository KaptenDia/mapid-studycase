import 'package:maplibre_gl/maplibre_gl.dart';
import '../data/model/geo_layer_model.dart';

class MapState {
  final bool isLoading;
  final String errorMessage;
  final GeoLayerResp? layerData;
  final GeoFeature? selectedFeature;
  final LatLng? userLocation;
  final bool isTrackingUser;
  final bool isMapReady;
  final bool isLayerVisible;

  const MapState({
    this.isLoading = false,
    this.errorMessage = '',
    this.layerData,
    this.selectedFeature,
    this.userLocation,
    this.isTrackingUser = false,
    this.isMapReady = false,
    this.isLayerVisible = true,
  });

  MapState copyWith({
    bool? isLoading,
    String? errorMessage,
    GeoLayerResp? layerData,
    GeoFeature? selectedFeature,
    bool clearSelectedFeature = false,
    LatLng? userLocation,
    bool? isTrackingUser,
    bool? isMapReady,
    bool? isLayerVisible,
  }) {
    return MapState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      layerData: layerData ?? this.layerData,
      selectedFeature: clearSelectedFeature
          ? null
          : (selectedFeature ?? this.selectedFeature),
      userLocation: userLocation ?? this.userLocation,
      isTrackingUser: isTrackingUser ?? this.isTrackingUser,
      isMapReady: isMapReady ?? this.isMapReady,
      isLayerVisible: isLayerVisible ?? this.isLayerVisible,
    );
  }

  List<GeoFeature> get features => layerData?.features ?? [];
  bool get hasFeatures => features.isNotEmpty;
}
