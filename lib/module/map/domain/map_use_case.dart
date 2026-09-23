import 'package:injectable/injectable.dart';
import '../../../helper/api/result_resp.dart';
import '../data/map_repository.dart';
import '../data/model/geo_layer_model.dart';

abstract class IMapUseCase {
  Future<ApiResp<GeoLayerResp>> executeGetLayerData();
}

@LazySingleton(as: IMapUseCase)
class MapUseCase implements IMapUseCase {
  final IMapRepository _repository;

  MapUseCase(this._repository);

  @override
  Future<ApiResp<GeoLayerResp>> executeGetLayerData() {
    return _repository.getLayerData();
  }
}
