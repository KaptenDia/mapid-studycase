class RegisterState {
  final String fullName;
  final String email;
  final String phone;
  final String password;
  final bool isFullNameValid;
  final bool isEmailValid;
  final bool isPhoneValid;
  final bool isPasswordValid;
  final bool isLoading;
  final String errorMessage;
  final bool isRegisterSuccess;

  RegisterState({
    this.fullName = '',
    this.email = '',
    this.phone = '',
    this.password = '',
    this.isFullNameValid = false,
    this.isEmailValid = false,
    this.isPhoneValid = false,
    this.isPasswordValid = false,
    this.isLoading = false,
    this.errorMessage = '',
    this.isRegisterSuccess = false,
  });

  bool get isFormValid => isEmailValid && isPasswordValid;

  RegisterState copyWith({
    String? fullName,
    String? email,
    String? phone,
    String? password,
    bool? isFullNameValid,
    bool? isEmailValid,
    bool? isPhoneValid,
    bool? isPasswordValid,
    bool? isLoading,
    String? errorMessage,
    bool? isRegisterSuccess,
  }) {
    return RegisterState(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      isFullNameValid: isFullNameValid ?? this.isFullNameValid,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPhoneValid: isPhoneValid ?? this.isPhoneValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      isRegisterSuccess: isRegisterSuccess ?? this.isRegisterSuccess,
    );
  }
}
