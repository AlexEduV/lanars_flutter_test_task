// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'picture_entry_wrapper.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PictureEntryWrapper _$PictureEntryWrapperFromJson(Map<String, dynamic> json) =>
    PictureEntryWrapper(
      photos: (json['photos'] as List<dynamic>)
          .map((e) => PictureEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PictureEntryWrapperToJson(
        PictureEntryWrapper instance) =>
    <String, dynamic>{
      'photos': instance.photos,
    };
