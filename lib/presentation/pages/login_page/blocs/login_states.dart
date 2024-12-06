abstract class LoginState {}

class LoginInitial extends LoginState {
  final bool isPasswordObscure;

  LoginInitial({this.isPasswordObscure = true});
}
class LoginLoading extends LoginState {}
class LoginSuccess extends LoginState {}
class LoginFailure extends LoginState {
  final String message;

  LoginFailure({required this.message});
}
class LoginError extends LoginState {
  final String emailError;
  final String passwordError;

  LoginError({required this.emailError, required this.passwordError});
}
