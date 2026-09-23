class AuthState {
  final bool isLogin;

  AuthState({
    this.isLogin = false,
  });

  AuthState copyWith({
    bool? isLogin,
  }) {
    return AuthState(
      isLogin: isLogin ?? this.isLogin,
    );
  }
}
