import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:lanars_flutter_test_task/data/storage/global_mock_storage.dart';
import 'package:lanars_flutter_test_task/domain/models/user.dart';

class DioClient {

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

      if (response.statusCode == 200) {
        return response.data['data'];
      }
      else {
        return 'Form Error';
      }

    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        return 'Connection Error - Timeout';
      }
      else if (e.type == DioExceptionType.badResponse) {
        return 'Server Error. Please, try again';
      }
    }

    return '';

  }

  static Future<String> getRandomUser() async {

    try {
      final response = await client.get(randomUserEndPoint);
      if (response.statusCode == 200) {
        //debugPrint(response.toString());

        //process data and put it into a global storage
        Map<String, dynamic> decodedResponse = jsonDecode(response.toString());
        final firstResult = decodedResponse['results'][0];

        GlobalMockStorage.user = User.fromJson(firstResult);

      }
      else {
        return 'Server Error. Please, try again';
      }

    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        return 'Connection Error - Timeout';
      }
      else if (e.type == DioExceptionType.badResponse) {
        return 'Server Error. Please, try again';
      }
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
      if (response.statusCode == 200) {
        debugPrint(response.toString());

        //convert to list of pictureData

      }
      else {
        return 'Server Error. Please, try again';
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        return 'Connection Error - Timeout';
      }
      else if (e.type == DioExceptionType.badResponse) {
        return 'Server Error. Please, try again';
      }
    }

    return '';
  }

}