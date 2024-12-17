import 'package:dio/dio.dart';
import 'package:lanars_flutter_test_task/data/network/dio_client.dart';
import 'package:lanars_flutter_test_task/domain/repositories/login_repository.dart';
import 'package:lanars_flutter_test_task/domain/usecases/get_random_person_usecase.dart';

class LoginRepositoryImpl implements LoginRepository {

  final randomUserEndPoint = 'https://randomuser.me/api/';


  @override
  Future<String> getRandomUser() async {

    try {

      final response = await DioClient.client.get(randomUserEndPoint);
      processPersonResponse(response);

    } on DioException catch (e) {
      DioClient.handleError(e);
    }

    return '';

  }

  @override
  Future<String> submitForm(Map<String, dynamic> formData) async {

    try {
      final response = await DioClient.client.post(
        randomUserEndPoint,
        data: formData,
      );

      return response.data['data'];

    } on DioException catch (e) {
      DioClient.handleError(e);
    }

    return '';

  }

}