final emailRegExp = RegExp(
  r"^[a-zA-Z0-9.!#$%&'*+\\/=?^_`{|}~-]{1,10}@(?:(?!.*--)[a-zA-Z0-9-]{1,10}(?<!-))(?:\.(?:[a-zA-Z0-9-]{2,10}))+$",
);

final passwordRegExp = RegExp(
  r"^(?=.*\d)(?=.*[A-Z])(?=.*[a-z]).*$"
);

String? validateEmail(String? email) {

  if (email == null || email.isEmpty) {
    return 'The field must not be empty';
  }
  else if (email.length < 6) {
    return 'The email is too short';
  }
  else if (email.length > 30) {
    return 'The email is too long';
  }
  else if (!emailRegExp.hasMatch(email)) {
    return 'Please, use an email like this: example@exmaple.com';
  }

  return null;

}

String? validatePassword(String? password) {

  if (password == null || password.isEmpty) {
    return 'The field must not be empty';
  }
  else if (password.length < 6) {
    return 'The password is too short';
  }
  else if (password.length > 10) {
    return 'The password is too long';
  }
  else if (!passwordRegExp.hasMatch(password)) {
    return 'Please, ensure that the password contains one uppercase, one lowercase, and a digit character';
  }

  return null;

}

