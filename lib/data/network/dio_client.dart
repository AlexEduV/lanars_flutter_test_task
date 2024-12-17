import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:lanars_flutter_test_task/data/storage/global_mock_storage.dart';
import 'package:lanars_flutter_test_task/domain/models/picture_entry.dart';
import 'package:lanars_flutter_test_task/domain/models/user.dart';

class DioClient {

  //todo: create repository and impls as per clean architecture
  //the response should just return data, not process it
  //the mock storage might need to be reworked
  //use retrofit as per project requirements


  static final Dio client = Dio();

  //endpoints
  static const randomUserEndPoint = 'https://randomuser.me/api/';
  static const picturesEndPoint = 'https://api.pexels.com/v1/curated?per_page=50';

  static const api = 'd0K2cyjHJ01jpHmINGkSZyoyrZ6CNxDUcsECbOdTzMeDG0AZpJteBDjp';

  static Future<String> submitForm(Map<String, dynamic> formData) async {

    try {
      final response = await client.post(
        randomUserEndPoint,
        data: formData,
      );

      return response.data['data'];

    } on DioException catch (e) {
      DioClient._handleError(e);
    }

    return '';

  }

  static Future<String> getRandomUser() async {

    try {

      final response = await client.get(randomUserEndPoint);
      //debugPrint(response.toString());

      //process data and put it into a global storage
      Map<String, dynamic> decodedResponse = jsonDecode(response.toString());
      final firstResult = decodedResponse['results'][0];

      GlobalMockStorage.user = User.fromJson(firstResult);

    } on DioException catch (e) {
      DioClient._handleError(e);
    }

    return '';

  }

  static Future<String> getPictures() async {

    try {

      final response = await client.get(
          picturesEndPoint,
          options: Options(
            headers: {
              'Authorization': api
            }
          )
      );

      //debugPrint(response.toString());

      //todo: move this to the domain layer
      //convert to list of picture entities
      final decodedJson = jsonDecode(response.toString());

      final List<PictureEntry> resultsList = (decodedJson['photos'] as List)
          .map((pictureJson) => PictureEntry.fromJson(pictureJson))
          .toList();

      //sort values by the name of the photographer
      resultsList.sort((a, b) => a.photographerName.compareTo(b.photographerName));

      GlobalMockStorage.results = resultsList;

    } on DioException catch (e) {
      DioClient._handleError(e);
    }

    return '';
  }

  static String _handleError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout) {
      return 'Connection Error - Timeout';
    }
    else if (e.type == DioExceptionType.badResponse) {
      return 'Server Error. Please, try again';
    }

    return 'Unknown Error';
  }

}
