import 'package:mapid/module/login/data/model/login_req.dart';
import 'package:injectable/injectable.dart';

import '../../../helper/api/result_resp.dart';
import '../data/login_repository.dart';

abstract class ILoginUseCase {
  Future<ApiResp> executeLogin(LoginReq loginReq);
}

@LazySingleton(as: ILoginUseCase)
class LoginUseCase implements ILoginUseCase {
  final ILoginRepository _loginRepository;

  LoginUseCase(this._loginRepository);

  @override
  Future<ApiResp> executeLogin(LoginReq loginReq) async {
    // Business rule validation (beyond UI validation)
    final validationError = _validateBusinessRules(loginReq);
    if (validationError != null) {
      return ErrorResp(message: validationError);
    }

    // Execute login
    return await _loginRepository.login(loginReq: loginReq);
  }

  /// Validate business rules that UI layer doesn't handle
  String? _validateBusinessRules(LoginReq loginReq) {
    // Additional business rules validation
    // Note: Basic "required" validation already handled by UI (FieldDefault)

    // Custom business rules (commented out, uncomment as needed):

    // 1. Validate username format (e.g., no special characters)
    // final username = loginReq.username?.trim() ?? '';
    // if (username.contains(RegExp(r'[<>]'))) {
    //   return 'Username tidak boleh mengandung karakter khusus';
    // }

    // 2. Validate minimum security requirements
    // final password = loginReq.password ?? '';
    // if (password.length < 6) {
    //   return 'Password minimal 6 karakter untuk keamanan';
    // }

    // 3. Check for common weak passwords
    // if (_isCommonPassword(password)) {
    //   return 'Password terlalu umum, gunakan password yang lebih kuat';
    // }

    // Add specific business rules here as needed

    return null; // No business rule violation
  }
}
