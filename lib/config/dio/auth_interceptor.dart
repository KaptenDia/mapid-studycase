import 'package:dio/dio.dart';

import '../../module/auth/data/auth_repository.dart';
import '../di/di.dart';

class AuthInterceptor extends Interceptor {
  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final userToken = getIt<IAuthRepository>().getToken();
      if (userToken != null) {
        options.headers = {'Authorization': 'Bearer $userToken'};
      }
      return super.onRequest(options, handler);
    } catch (e, _) {
      return super.onRequest(options, handler);
    }
  }
}
