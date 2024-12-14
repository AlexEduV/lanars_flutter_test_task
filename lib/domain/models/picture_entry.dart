import 'package:json_annotation/json_annotation.dart';

part 'picture_entry.g.dart';

@JsonSerializable()
class PictureEntry {

  @JsonKey(name: 'src', fromJson: _extractImageSrc) final String imageSrc;
  @JsonKey(name: 'photographer') final String photographerName;
  @JsonKey(name: 'alt', defaultValue: '') final String altTitle;

  const PictureEntry({
    required this.imageSrc,
    required this.photographerName,
    required this.altTitle,
  });

  factory PictureEntry.fromJson(Map<String, dynamic> json) =>
      _$PictureEntryFromJson(json);

  static String _extractImageSrc(Map<String, dynamic> src) =>
      src['small'] as String;

}