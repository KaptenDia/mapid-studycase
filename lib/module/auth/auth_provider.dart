import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../config/di/di.dart';
import 'auth_state.dart';
import 'data/auth_repository.dart';

part 'auth_provider.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  AuthState build() => AuthState();

  void setLogin() => state = state.copyWith(isLogin: true);

  void setLogout() {
    getIt<IAuthRepository>()
      ..clearToken()
      ..clearProfile();
    // ref.read(profileNotifierProvider.notifier).clearProfile();
    state = state.copyWith(isLogin: false);
  }
}
