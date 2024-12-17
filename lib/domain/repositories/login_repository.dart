import 'package:dio/dio.dart';

abstract class LoginRepository {

  Future<String> submitForm(Dio client, Map<String, dynamic> data);
  Future<String> getRandomUser(Dio client);

}