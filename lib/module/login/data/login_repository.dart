import 'package:baseproject_flutter/module/login/data/model/login_resp.dart';
import 'package:injectable/injectable.dart';

import '../../../helper/api/result_resp.dart';
import 'login_local_data.dart';
import 'login_remote_data.dart';
import 'model/login_req.dart';

abstract class ILoginRepository {
  Future<ApiResp<LoginResp>> login({required LoginReq loginReq});
  User? getProfile();
}

@LazySingleton(as: ILoginRepository)
class LoginRepository implements ILoginRepository {
  final ILoginRemoteData _loginRemoteData;
  final ILoginLocalData _loginLocalData;

  LoginRepository(this._loginRemoteData, this._loginLocalData);

  @override
  Future<ApiResp<LoginResp>> login({required LoginReq loginReq}) async {
    final result = await _loginRemoteData.login(loginReq: loginReq);

    if (result is SuccessResp<LoginResp>) {
      await _loginLocalData.setToken(result.data?.token ?? '-');
      await _loginLocalData.setProfile(result.data?.user ?? User());
    }

    return result;
  }

  @override
  User? getProfile() {
    return _loginLocalData.getProfile();
  }
}
