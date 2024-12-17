import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:lanars_flutter_test_task/data/storage/global_mock_storage.dart';
import 'package:lanars_flutter_test_task/domain/models/user.dart';

void processPersonResponse(Response response) {

  //process data and put it into a global storage
  Map<String, dynamic> decodedResponse = jsonDecode(response.toString());
  final firstResult = decodedResponse['results'][0];

  GlobalMockStorage.user = User.fromJson(firstResult);
}