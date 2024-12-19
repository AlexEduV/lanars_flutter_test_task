import 'package:dio/dio.dart';
import 'package:lanars_flutter_test_task/domain/models/user_wrapper.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'user_api_service.g.dart';

const randomUserEndPoint = 'https://randomuser.me/api/';

@RestApi(baseUrl: randomUserEndPoint)
abstract class UserApiService {
  factory UserApiService(Dio dio, {String baseUrl}) = _UserApiService;

  @GET('/')
  Future<UserWrapper> getRandomUser();

  @POST('/')
  Future<void> submitForm(@Body() Map<String, dynamic> formData);

}
