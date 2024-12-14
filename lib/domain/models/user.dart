import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {

  @JsonKey(name: 'picture', fromJson: _extractAvatarImage)
  final String avatarImageSrc;

  @JsonKey(name: 'name', fromJson: _extractFirstName)
  final String firstName;

  @JsonKey(name: 'last', fromJson: _extractLastName)
  final String lastName;

  final String email;

  const User({
    required this.avatarImageSrc,
    required this.firstName,
    required this.lastName,
    required this.email,
  });


  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  // Helper methods for avatarImageSrc
  static String _extractAvatarImage(Map<String, dynamic> picture) =>
      picture['medium'] as String;

  // Helper methods for firstName
  static String _extractFirstName(Map<String, dynamic> name) =>
      name['first'] as String;

  // Helper methods for lastName
  static String _extractLastName(Map<String, dynamic> name) =>
      name['last'] as String;

}