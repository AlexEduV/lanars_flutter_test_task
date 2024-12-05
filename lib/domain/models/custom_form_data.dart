class CustomFormData {
  final String email;
  final String password;

  const CustomFormData({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() => <String, dynamic>{
    'email': email,
    'password': password,
  };
}
