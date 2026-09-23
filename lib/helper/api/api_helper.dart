import 'dart:developer';

import 'package:dio/dio.dart';

import '../../const/code.dart';
import 'result_resp.dart';

(bool, ApiResp<T>) parseResponse<T>(
  Response<dynamic> result,
  T Function(Map<String, dynamic>) fromJsonT,
) {
  final json = result.data;
  if (!isJsonContentType(result.headers)) {
    log('[parseResponse] => not json content type');
    return (
      false,
      ErrorResp.fromJson({
        "statusCode": respBodyCode.programCodeError,
        "message": json.toString().replaceAll('\n', ''),
      }),
    );
  } else if (result.statusCode! >= 200 && result.statusCode! < 300) {
    log('[parseResponse] => success');
    return (true, SuccessResp.fromJson(json, fromJsonT(json['data'] ?? {})));
  } else {
    log('[parseResponse] => error');
    // json['message'] = '[${json['statusCode']}] ${json['message']}';
    return (false, ErrorResp.fromJson(json));
  }
}

(bool, ApiResp<T>) parseResponseList<T>(
  Response<dynamic> result,
  T Function(List<dynamic>) fromJsonT,
) {
  final json = result.data;
  if (!isJsonContentType(result.headers)) {
    log('[parseResponse] => not json content type');
    return (
      false,
      ErrorResp.fromJson({
        "statusCode": respBodyCode.programCodeError,
        "message": json.toString().replaceAll('\n', ''),
      }),
    );
  } else if (result.statusCode! >= 200 && result.statusCode! < 300) {
    log('[parseResponse] => success');
    return (true, SuccessResp.fromJson(json, fromJsonT(json['data'] ?? {})));
  } else {
    log('[parseResponse] => error');
    // json['message'] = '[${json['statusCode']}] ${json['message']}';
    return (false, ErrorResp.fromJson(json));
  }
}

bool isJsonContentType(Headers headers) {
  return headers['content-type']?.contains('application/json; charset=utf-8') ??
      false;
}
