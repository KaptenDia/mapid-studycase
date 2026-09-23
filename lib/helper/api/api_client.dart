import 'package:dio/dio.dart';
import 'package:flutter_pretty_dio_logger/flutter_pretty_dio_logger.dart';
import 'package:injectable/injectable.dart';

import '../../config/dio/auth_interceptor.dart';
import '../../const/url.dart';
import '../../flavors.dart';
import 'package:baseproject_flutter/helper/navigator.dart';

@lazySingleton
class ApiClient {
  final Dio _dio;

  ApiClient(this._dio) {
    _dio.interceptors.add(AuthInterceptor());
    if (F.appFlavor == Flavor.dev || F.appFlavor == Flavor.staging) {
      _dio.interceptors.add(samseer.dioInterceptor);
    }
    _dio.interceptors.add(
      PrettyDioLogger(
        canShowLog: true,
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        showProcessingTime: true,
        showCUrl: false,
        convertFormData: true,
      ),
    );
  }

  Future<Response> post({
    required String path,
    String? baseUrl,
    dynamic data,
  }) async {
    String base = baseUrl ?? urlBase;
    final result = await _dio.post('$base$path', data: data);
    return result;
  }

  Future<Response> get({
    required String path,
    String? baseUrl,
    dynamic queryParameters,
  }) async {
    String base = baseUrl ?? urlBase;
    final result = await _dio.get(
      '$base$path',
      queryParameters: queryParameters,
    );
    return result;
  }

  Future<Response> put({
    required String path,
    String? baseUrl,
    dynamic data,
  }) async {
    String base = baseUrl ?? urlBase;
    final result = await _dio.put('$base$path', data: data);
    return result;
  }
}
