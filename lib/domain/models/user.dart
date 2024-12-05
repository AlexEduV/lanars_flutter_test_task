class User {

  final String avatarImageSrc;
  final String firstName;
  final String lastName;
  final String email;

  const User({
    required this.avatarImageSrc,
    required this.firstName,
    required this.lastName,
    required this.email,
  });


  factory User.fromJson(Map<String, dynamic> json) {

    return User(
      firstName: json['name']['first'],
      lastName: json['name']['last'],
      avatarImageSrc: json['picture']['medium'],
      email: json['email']
    );

  }

}