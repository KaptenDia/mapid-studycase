import 'package:injectable/injectable.dart';
import '../../../helper/api/result_resp.dart';
import 'map_remote_data.dart';
import 'model/geo_layer_model.dart';

abstract class IMapRepository {
  Future<ApiResp<GeoLayerResp>> getLayerData();
}

@LazySingleton(as: IMapRepository)
class MapRepository implements IMapRepository {
  final IMapRemoteData _remoteData;

  MapRepository(this._remoteData);

  @override
  Future<ApiResp<GeoLayerResp>> getLayerData() {
    return _remoteData.fetchLayerData();
  }
}
