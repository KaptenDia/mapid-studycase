import 'dart:developer';

import 'package:baseproject_flutter/module/register/data/model/register_resp.dart';
import 'package:injectable/injectable.dart';

import '../../../const/url.dart';
import '../../../helper/api/api_client.dart';
import '../../../helper/api/api_helper.dart';
import '../../../helper/api/result_resp.dart';
import 'model/register_req.dart';

abstract class IRegisterRemoteData {
  Future<ApiResp<RegisterResp>> register({required RegisterReq registerReq});
}

@LazySingleton(as: IRegisterRemoteData)
class RegisterRemoteData implements IRegisterRemoteData {
  final ApiClient _apiClient;

  RegisterRemoteData(this._apiClient);

  @override
  Future<ApiResp<RegisterResp>> register({
    required RegisterReq registerReq,
  }) async {
    try {
      final result = await _apiClient.post(
        path: urlRegister,
        data: registerReq.toJson(),
      );
      final (_, resp) = parseResponse<RegisterResp>(
        result,
        (json) => RegisterResp.fromJson(json),
      );
      return resp;
    } catch (e) {
      log(e.toString());
      return ErrorResp();
    }
  }
}
