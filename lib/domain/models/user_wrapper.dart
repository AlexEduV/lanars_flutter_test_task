import 'package:json_annotation/json_annotation.dart';
import 'package:lanars_flutter_test_task/domain/models/user.dart';

part 'user_wrapper.g.dart';

@JsonSerializable()
class UserWrapper {
  final List<User> results;

  UserWrapper({required this.results});

  factory UserWrapper.fromJson(Map<String, dynamic> json) =>
      _$UserWrapperFromJson(json);
}