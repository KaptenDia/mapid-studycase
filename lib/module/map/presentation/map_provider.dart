import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../config/di/di.dart';
import '../../../helper/api/result_resp.dart';
import '../data/model/geo_layer_model.dart';
import '../domain/map_state.dart';
import '../domain/map_use_case.dart';

part 'map_provider.g.dart';

@riverpod
class MapNotifier extends _$MapNotifier {
  late final IMapUseCase _useCase;

  @override
  MapState build() {
    _useCase = getIt<IMapUseCase>();
    // Automatically load layer on start
    fetchLayerData();
    return const MapState();
  }

  Future<void> fetchLayerData() async {
    state = state.copyWith(isLoading: true, errorMessage: '');
    final result = await _useCase.executeGetLayerData();

    if (result is SuccessResp<GeoLayerResp>) {
      state = state.copyWith(
        isLoading: false,
        layerData: result.data,
      );
    } else if (result is ErrorResp) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: (result.message?.isNotEmpty ?? false)
            ? result.message!
            : 'Gagal memuat layer dari GEO MAPID',
      );
    } else {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Terjadi kesalahan tidak terduga',
      );
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
