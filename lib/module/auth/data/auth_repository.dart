import 'package:injectable/injectable.dart';

import '../../login/data/login_local_data.dart';

abstract class IAuthRepository {
  String? getToken();
  Future clearToken();
  Future clearProfile();
}

@LazySingleton(as: IAuthRepository)
class AuthRepository implements IAuthRepository {
  final ILoginLocalData _loginLocalData;

  AuthRepository(this._loginLocalData);

  @override
  String? getToken() => _loginLocalData.getToken();

  @override
  Future clearToken() => _loginLocalData.clearToken();

  @override
  Future clearProfile() => _loginLocalData.clearProfile();
}
