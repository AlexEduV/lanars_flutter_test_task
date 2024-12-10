abstract class LoginEvent {}

class LoginSubmitted extends LoginEvent {
  final String email;
  final String password;

  LoginSubmitted({required this.email, required this.password});
}

class ClearEmailErrors extends LoginEvent {}
class ClearPasswordErrors extends LoginEvent {}


class TogglePasswordVisibility extends LoginEvent {}


class EmailUnfocused extends LoginEvent {
  final String email;

  EmailUnfocused({required this.email});

}

class PasswordUnfocused extends LoginEvent {
  final String password;

  PasswordUnfocused({required this.password});
}
