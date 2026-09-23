import 'dart:developer';

import 'package:baseproject_flutter/module/login/data/model/login_resp.dart';
import 'package:injectable/injectable.dart';

import '../../../const/url.dart';
import '../../../helper/api/api_client.dart';
import '../../../helper/api/api_helper.dart';
import '../../../helper/api/result_resp.dart';
import 'model/login_req.dart';

abstract class ILoginRemoteData {
  Future<ApiResp<LoginResp>> login({required LoginReq loginReq});
}

@LazySingleton(as: ILoginRemoteData)
class LoginRemoteData implements ILoginRemoteData {
  final ApiClient _apiClient;

  LoginRemoteData(this._apiClient);

  @override
  Future<ApiResp<LoginResp>> login({required LoginReq loginReq}) async {
    try {
      final result = await _apiClient.post(
        path: urlLogin,
        data: loginReq.toJson(),
      );
      final (_, resp) = parseResponse<LoginResp>(
        result,
        (json) => LoginResp.fromJson(json),
      );
      return resp;
    } catch (e) {
      log(e.toString());
      return ErrorResp();
    }
  }
}
