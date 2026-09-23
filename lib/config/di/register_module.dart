import 'package:dio/dio.dart';
import 'package:encrypt_shared_preferences/provider.dart';
import 'package:injectable/injectable.dart';

@module
abstract class RegisterModule {
  EncryptedSharedPreferences get prefs =>
      EncryptedSharedPreferences.getInstance();

  Dio get httpClient {
    const timeout = Duration(minutes: 1);
    final options = BaseOptions(
      connectTimeout: timeout,
      receiveTimeout: timeout,
      validateStatus: (_) => true,
    );
    return Dio(options);
  }
}
