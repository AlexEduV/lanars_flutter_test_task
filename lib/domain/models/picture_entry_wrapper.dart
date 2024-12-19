import 'package:json_annotation/json_annotation.dart';
import 'package:lanars_flutter_test_task/domain/models/picture_entry.dart';

part 'picture_entry_wrapper.g.dart';

@JsonSerializable()
class PictureEntryWrapper {

  final List<PictureEntry> photos;

  PictureEntryWrapper({required this.photos});

  factory PictureEntryWrapper.fromJson(Map<String, dynamic> json) =>
      _$PictureEntryWrapperFromJson(json);

}
