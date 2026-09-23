import 'dart:convert';

import 'package:mapid/module/register/data/model/register_resp.dart';
import 'package:encrypt_shared_preferences/provider.dart';
import 'package:injectable/injectable.dart';

abstract class IRegisterLocalData {
  Future setUserData(RegisterResp userData);
  RegisterResp? getUserData();
  Future clearUserData();
}

@LazySingleton(as: IRegisterLocalData)
class RegisterLocalData implements IRegisterLocalData {
  final EncryptedSharedPreferences prefs;

  RegisterLocalData(this.prefs);

  final String _keyUserData = 'register_user_data';

  @override
  Future setUserData(RegisterResp userData) async =>
      prefs.setString(_keyUserData, jsonEncode(userData.toJson()));

  @override
  RegisterResp? getUserData() {
    final userDataString = prefs.getString(_keyUserData);
    if (userDataString != null) {
      return RegisterResp.fromJson(jsonDecode(userDataString));
    }
    return null;
  }

  @override
  Future clearUserData() => prefs.remove(_keyUserData);
}
