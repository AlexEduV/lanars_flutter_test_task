// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      avatarImageSrc:
          User._extractAvatarImage(json['picture'] as Map<String, dynamic>),
      firstName: User._extractFirstName(json['name'] as Map<String, dynamic>),
      lastName: User._extractLastName(json['name'] as Map<String, dynamic>),
      email: json['email'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'picture': instance.avatarImageSrc,
      'name': instance.firstName,
      'last': instance.lastName,
      'email': instance.email,
    };
