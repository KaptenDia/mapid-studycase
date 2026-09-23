import 'package:baseproject_flutter/module/register/data/model/register_req.dart';
import 'package:injectable/injectable.dart';

import '../../../helper/api/result_resp.dart';
import '../data/register_repository.dart';

abstract class IRegisterUseCase {
  Future<ApiResp> executeRegister(RegisterReq registerReq);
}

@LazySingleton(as: IRegisterUseCase)
class RegisterUseCase implements IRegisterUseCase {
  final IRegisterRepository _registerRepository;

  RegisterUseCase(this._registerRepository);

  @override
  Future<ApiResp> executeRegister(RegisterReq registerReq) async {
    // Business rule validation (beyond UI validation)
    final validationError = _validateBusinessRules(registerReq);
    if (validationError != null) {
      return ErrorResp(message: validationError);
    }

    // Execute register
    return await _registerRepository.register(registerReq: registerReq);
  }

  /// Validate business rules that UI layer doesn't handle
  String? _validateBusinessRules(RegisterReq registerReq) {
    // Additional business rules validation
    // Note: Basic validation already handled by UI (FieldDefault)

    // Custom business rules (commented out, uncomment as needed):

    // 1. Validate name format (e.g., no numbers)
    // final name = registerReq.name?.trim() ?? '';
    // if (name.contains(RegExp(r'[0-9]'))) {
    //   return 'Nama tidak boleh mengandung angka';
    // }

    // 2. Validate phone format (Indonesian format)
    // final phone = registerReq.phone ?? '';
    // if (!RegExp(r'^(\+62|62|0)8[1-9][0-9]{6,9}$').hasMatch(phone)) {
    //   return 'Format nomor telepon tidak valid';
    // }

    // 3. Validate password strength
    // final password = registerReq.password ?? '';
    // if (password.length < 8) {
    //   return 'Password minimal 8 karakter untuk keamanan';
    // }

    // 4. Check for email domain restrictions
    // final email = registerReq.email ?? '';
    // if (email.endsWith('@tempmail.com')) {
    //   return 'Email temporary tidak diperbolehkan';
    // }

    // Add specific business rules here as needed

    return null; // No business rule violation
  }
}
