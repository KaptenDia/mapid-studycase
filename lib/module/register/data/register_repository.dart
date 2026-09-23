import 'package:mapid/module/register/data/model/register_resp.dart';
import 'package:injectable/injectable.dart';

import '../../../helper/api/result_resp.dart';
import 'register_local_data.dart';
import 'register_remote_data.dart';
import 'model/register_req.dart';

abstract class IRegisterRepository {
  Future<ApiResp<RegisterResp>> register({required RegisterReq registerReq});
  RegisterResp? getUserData();
}

@LazySingleton(as: IRegisterRepository)
class RegisterRepository implements IRegisterRepository {
  final IRegisterRemoteData _registerRemoteData;
  final IRegisterLocalData _registerLocalData;

  RegisterRepository(this._registerRemoteData, this._registerLocalData);

  @override
  Future<ApiResp<RegisterResp>> register({
    required RegisterReq registerReq,
  }) async {
    final result = await _registerRemoteData.register(registerReq: registerReq);

    if (result is SuccessResp<RegisterResp>) {
      await _registerLocalData.setUserData(result.data ?? RegisterResp());
    }

    return result;
  }

  @override
  RegisterResp? getUserData() {
    return _registerLocalData.getUserData();
  }
}
