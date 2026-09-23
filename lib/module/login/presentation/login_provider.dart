import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../config/di/di.dart';
import '../../../helper/api/result_resp.dart';
import '../data/model/login_req.dart';
import '../domain/login_state.dart';
import '../domain/login_use_case.dart';

part 'login_provider.g.dart';

@riverpod
class LoginNotifier extends _$LoginNotifier {
  late final ILoginUseCase _loginUseCase;

  @override
  LoginState build() {
    _loginUseCase = getIt<ILoginUseCase>();
    return LoginState();
  }

  void setEmail(String email, bool isValid) =>
      state = state.copyWith(email: email, isEmailValid: isValid);

  void setPassword(String password, bool isValid) =>
      state = state.copyWith(password: password, isPasswordValid: isValid);

  void onPressedLogin() async {
    state = state.copyWith(isLoading: true, errorMessage: '');
    final result = await _loginUseCase.executeLogin(
      LoginReq(username: state.email, password: state.password),
    );
    state = state.copyWith(
      isLoading: false,
      errorMessage: result is ErrorResp ? result.message : '',
      isLoginSuccess: result is! ErrorResp,
    );
  }
}
