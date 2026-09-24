import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../config/di/di.dart';
import '../../../helper/api/result_resp.dart';
import '../data/model/geo_layer_model.dart';
import '../domain/map_state.dart';
import '../domain/map_use_case.dart';

part 'map_provider.g.dart';

@Riverpod(keepAlive: true)
class MapNotifier extends _$MapNotifier {
  late final IMapUseCase _useCase;
  bool _isFetching = false;

  @override
  MapState build() {
    _useCase = getIt<IMapUseCase>();
    // Automatically trigger initial layer fetch when provider is initialized
    Future.microtask(() => fetchLayerData());
    return const MapState();
  }

  Future<void> fetchLayerData({bool force = false}) async {
    if (_isFetching && !force) return;
    _isFetching = true;

    state = state.copyWith(isLoading: true, errorMessage: '');
    try {
      final result = await _useCase.executeGetLayerData();

      if (result is SuccessResp<GeoLayerResp>) {
        state = state.copyWith(
          isLoading: false,
          layerData: result.data,
          errorMessage: '',
        );
      } else if (result is ErrorResp) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: (result.message?.isNotEmpty ?? false)
              ? result.message!
              : 'Failed to load layer from GEO MAPID',
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'An unexpected error occurred',
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    } finally {
      _isFetching = false;
    }
  }

  void selectFeature(GeoFeature? feature) {
    if (feature == null) {
      state = state.copyWith(clearSelectedFeature: true);
    } else {
      state = state.copyWith(selectedFeature: feature);
    }
  }

  void setUserLocation(LatLng location) {
    state = state.copyWith(userLocation: location);
  }

  void setMapReady(bool ready) {
    state = state.copyWith(isMapReady: ready);
  }

  void toggleLayerVisibility() {
    state = state.copyWith(isLayerVisible: !state.isLayerVisible);
  }
}
