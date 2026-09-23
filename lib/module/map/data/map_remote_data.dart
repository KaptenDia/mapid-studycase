import 'dart:developer';
import 'package:injectable/injectable.dart';
import '../../../const/env_config.dart';
import '../../../helper/api/api_client.dart';
import '../../../helper/api/result_resp.dart';
import 'model/geo_layer_model.dart';

abstract class IMapRemoteData {
  Future<ApiResp<GeoLayerResp>> fetchLayerData();
}

@LazySingleton(as: IMapRemoteData)
class MapRemoteData implements IMapRemoteData {
  final ApiClient _apiClient;

  MapRemoteData(this._apiClient);

  @override
  Future<ApiResp<GeoLayerResp>> fetchLayerData() async {
    try {
      final result = await _apiClient.get(
        baseUrl: EnvConfig.mapidGeoServerUrl,
        path: '',
        queryParameters: {
          'api_key': EnvConfig.mapidApiKey,
          'layer_id': EnvConfig.mapidLayerId,
          'project_id': EnvConfig.mapidProjectId,
        },
      );

      if (result.statusCode != null &&
          result.statusCode! >= 200 &&
          result.statusCode! < 300) {
        final data = result.data;
        if (data is Map<String, dynamic>) {
          return SuccessResp(
            code: result.statusCode.toString(),
            message: 'Success',
            data: GeoLayerResp.fromJson(data),
          );
        }
      }
      return ErrorResp(message: 'Failed to load GEO MAPID layer data');
    } catch (e) {
      log('MapRemoteData error: $e');
      return ErrorResp(message: e.toString());
    }
  }
}
