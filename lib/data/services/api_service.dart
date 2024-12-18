import 'package:dio/dio.dart';
import 'package:lanars_flutter_test_task/domain/models/user.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'api_service.g.dart';

const randomUserEndPoint = 'https://randomuser.me/api/';

@RestApi(baseUrl: randomUserEndPoint)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET('/')
  Future<User> getRandomUser();

  @POST('/')
  Future<void> submitForm(@Body() Map<String, dynamic> formData);

}
