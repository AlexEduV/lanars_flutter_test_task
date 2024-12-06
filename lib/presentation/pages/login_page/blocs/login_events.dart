abstract class LoginEvent {}

class LoginSubmitted extends LoginEvent {
  final String email;
  final String password;

  LoginSubmitted({required this.email, required this.password});
}

class ClearErrors extends LoginEvent {}


class TogglePasswordVisibility extends LoginEvent {}


class EmailFocusChanged extends LoginEvent {
  final bool isFocused;
  final String email;

  EmailFocusChanged({required this.isFocused, required this.email});

}

class PasswordFocusChanged extends LoginEvent {
  final bool isFocused;
  final String password;

  PasswordFocusChanged({required this.isFocused, required this.password});
}
