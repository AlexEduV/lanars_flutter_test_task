// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_wrapper.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserWrapper _$UserWrapperFromJson(Map<String, dynamic> json) => UserWrapper(
      results: (json['results'] as List<dynamic>)
          .map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserWrapperToJson(UserWrapper instance) =>
    <String, dynamic>{
      'results': instance.results,
    };
