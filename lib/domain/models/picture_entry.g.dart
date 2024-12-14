// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'picture_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PictureEntry _$PictureEntryFromJson(Map<String, dynamic> json) => PictureEntry(
      imageSrc:
          PictureEntry._extractImageSrc(json['src'] as Map<String, dynamic>),
      photographerName: json['photographer'] as String,
      altTitle: json['alt'] as String? ?? '',
    );

Map<String, dynamic> _$PictureEntryToJson(PictureEntry instance) =>
    <String, dynamic>{
      'src': instance.imageSrc,
      'photographer': instance.photographerName,
      'alt': instance.altTitle,
    };
