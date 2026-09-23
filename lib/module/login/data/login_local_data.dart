import 'dart:convert';

import 'package:mapid/module/login/data/model/login_resp.dart';
import 'package:encrypt_shared_preferences/provider.dart';
import 'package:injectable/injectable.dart';

abstract class ILoginLocalData {
  Future setToken(String token);
  String? getToken();
  Future clearToken();
  Future setProfile(User profile);
  User? getProfile();
  Future clearProfile();
  bool isLogin();
}

@LazySingleton(as: ILoginLocalData)
class LoginLocalData implements ILoginLocalData {
  final EncryptedSharedPreferences prefs;

  LoginLocalData(this.prefs);

  final String _keyToken = 'token';
  final String _keyProfile = 'profile';

  @override
  Future setToken(String token) => prefs.setString(_keyToken, token);

  @override
  String? getToken() => prefs.getString(_keyToken);

  @override
  bool isLogin() => prefs.getString(_keyToken) != null;

  @override
  Future clearToken() => prefs.remove(_keyToken);

  @override
  Future clearProfile() => prefs.remove(_keyProfile);

  @override
  Future setProfile(User profile) async =>
      prefs.setString(_keyProfile, jsonEncode(profile.toJson()));

  @override
  User? getProfile() {
    final profileString = prefs.getString(_keyProfile);
    if (profileString != null) {
      return User.fromJson(jsonDecode(profileString));
    }
    return null;
  }
}
