import 'package:equatable/equatable.dart';

abstract class LoginState {}

class LoginInitial extends LoginState with EquatableMixin {
  final bool isPasswordObscure;
  final bool isEmailFocused;
  final bool isPasswordFocused;
  final String? emailError;
  final String? passwordError;

  LoginInitial({
    this.isPasswordObscure = true,
    this.isEmailFocused = false,
    this.isPasswordFocused = false,
    this.emailError,
    this.passwordError,
  });

  @override
  List<Object?> get props => [
    isPasswordObscure,
    isEmailFocused,
    isPasswordFocused,
    emailError,
    passwordError,
  ];

  LoginInitial copyWith({
    bool? isPasswordObscure,
    bool? isEmailFocused,
    bool? isPasswordFocused,
    String? emailError,
    String? passwordError,
  }) {

    return LoginInitial(
      isPasswordObscure: isPasswordObscure ?? this.isPasswordObscure,
      isEmailFocused: isEmailFocused ?? this.isEmailFocused,
      isPasswordFocused: isPasswordFocused ?? this.isPasswordFocused,
      emailError: emailError ?? this.emailError,
      passwordError: passwordError ?? this.passwordError,
    );
  }

}
class LoginLoading extends LoginState {}
class LoginSuccess extends LoginState {}
class LoginFailure extends LoginState {
  final String message;

  LoginFailure({required this.message});
}
class LoginError extends LoginState with EquatableMixin {
  final String? emailError;
  final String? passwordError;

  LoginError({
    this.emailError,
    this.passwordError,
  });

  @override
  List<Object?> get props => [
    emailError,
    passwordError,
  ];

  LoginError copyWith({
    String? emailError,
    String? passwordError,
  }) {

    return LoginError(
      emailError: emailError,
      passwordError: passwordError,
    );
  }
}
