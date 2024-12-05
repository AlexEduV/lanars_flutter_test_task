import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:lanars_flutter_test_task/data/storage/global_mock_storage.dart';
import 'package:lanars_flutter_test_task/domain/models/user.dart';

class DioClient {

  static final Dio client = Dio();

  //endpoints
  static const endPoint = 'https://randomuser.me/api/';

  static Future<String> submitForm(Map<String, dynamic> formData) async {

    try {
      final response = await client.post(
        endPoint,
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

      final response = await client.get(endPoint);
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

}