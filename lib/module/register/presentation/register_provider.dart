import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../config/di/di.dart';
import '../../../helper/api/result_resp.dart';
import '../../../shared/widget/modal/default_modal.dart';
import '../../../shared/widget/modal/success_modal.dart';
import '../data/model/register_req.dart';
import '../domain/register_state.dart';
import '../domain/register_use_case.dart';

part 'register_provider.g.dart';

@riverpod
class RegisterNotifier extends _$RegisterNotifier {
  late final IRegisterUseCase _registerUseCase;

  @override
  RegisterState build() {
    _registerUseCase = getIt<IRegisterUseCase>();
    return RegisterState();
  }

  void setFullName(String fullName, bool isValid) =>
      state = state.copyWith(fullName: fullName, isFullNameValid: isValid);

  void setEmail(String email, bool isValid) =>
      state = state.copyWith(email: email, isEmailValid: isValid);

  void setPhone(String phone, bool isValid) =>
      state = state.copyWith(phone: phone, isPhoneValid: isValid);

  void setPassword(String password, bool isValid) =>
      state = state.copyWith(password: password, isPasswordValid: isValid);

  void onPressedRegister() async {
    state = state.copyWith(isLoading: true, errorMessage: '');

    final result = await _registerUseCase.executeRegister(
      RegisterReq(
        name: state.fullName,
        email: state.email,
        phone: state.phone,
        password: state.password,
      ),
    );

    state = state.copyWith(
      isLoading: false,
      errorMessage: result is ErrorResp ? (result.message ?? '') : '',
      isRegisterSuccess: result is! ErrorResp,
    );

    // Show modal and clear form on success
    if (result is! ErrorResp) {
      showSuccessModal(message: 'Registrasi berhasil! Akun Anda telah dibuat.');
      _clearForm();
    } else {
      showDefaultModal(
        message: result.message ?? 'Terjadi kesalahan saat registrasi.',
      );
    }
  }

  void _clearForm() {
    state = RegisterState();
  }
}
