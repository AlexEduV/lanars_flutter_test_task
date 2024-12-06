abstract class LoginState {}

class LoginInitial extends LoginState {
  final bool isPasswordObscure;
  final bool isEmailFocused;
  final bool isPasswordFocused;

  LoginInitial({
    this.isPasswordObscure = true,
    this.isEmailFocused = false,
    this.isPasswordFocused = false,
  });

  LoginInitial copyWith({
    bool? isPasswordObscure,
    bool? isEmailFocused,
    bool? isPasswordFocused,
  }) {
    return LoginInitial(
      isPasswordObscure: isPasswordObscure ?? this.isPasswordObscure,
      isEmailFocused: isEmailFocused ?? this.isEmailFocused,
      isPasswordFocused: isPasswordFocused ?? this.isPasswordFocused,
    );
  }

}
class LoginLoading extends LoginState {}
class LoginSuccess extends LoginState {}
class LoginFailure extends LoginState {
  final String message;

  LoginFailure({required this.message});
}
class LoginError extends LoginState {
  final String? emailError;
  final String? passwordError;

  LoginError({
    this.emailError = '',
    this.passwordError = '',
  });

  LoginError copyWith({
    String? emailError,
    String? passwordError,
  }) {
    return LoginError(
      emailError: emailError ?? this.emailError,
      passwordError: passwordError ?? this.passwordError,
    );
  }
}
