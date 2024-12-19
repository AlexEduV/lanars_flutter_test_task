import 'package:dio/dio.dart';
import 'package:lanars_flutter_test_task/data/network/dio_client.dart';
import 'package:lanars_flutter_test_task/data/services/user_api_service.dart';
import 'package:lanars_flutter_test_task/data/storage/global_mock_storage.dart';
import 'package:lanars_flutter_test_task/domain/models/user_wrapper.dart';
import 'package:lanars_flutter_test_task/domain/repositories/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {

  final randomUserEndPoint = 'https://randomuser.me/api/';

  @override
  Future<String> getRandomUser(Dio client) async {

    try {

      final UserApiService service = UserApiService(client);
      final UserWrapper response = await service.getRandomUser();
      if (response.results.isNotEmpty) {
        GlobalMockStorage.user = response.results.first;
      }

    } on DioException catch (e) {
      DioClient.handleError(e);
    }

    return '';

  }

  @override
  Future<String> submitForm(Dio client, Map<String, dynamic> formData) async {

    try {

      final UserApiService service = UserApiService(client);
      await service.submitForm(formData);

    } on DioException catch (e) {
      DioClient.handleError(e);
    }

    return '';

  }

}