import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:lanars_flutter_test_task/data/storage/global_mock_storage.dart';
import 'package:lanars_flutter_test_task/domain/models/picture_entry.dart';

//MARK: OBSOLETE

// void processImagesResponse(Response response) {
//
//   //convert to list of picture entities
//   final decodedJson = jsonDecode(response.toString());
//
//   final List<PictureEntry> resultsList = (decodedJson['photos'] as List)
//       .map((pictureJson) => PictureEntry.fromJson(pictureJson))
//       .toList();
//
//   //sort values by the name of the photographer
//   resultsList.sort((a, b) => a.photographerName.compareTo(b.photographerName));
//
//   GlobalMockStorage.results = resultsList;
// }