import 'package:dio/dio.dart';
import 'package:lanars_flutter_test_task/domain/models/user.dart';
import 'package:lanars_flutter_test_task/domain/models/user_wrapper.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'api_service.g.dart';

const randomUserEndPoint = 'https://randomuser.me/api/';

// todo: the user get request is nested, so the response is not mapped correctly
// because in the non-retrofit scenario it was preprocessed before conversion to
// dto. I probably need to move processing from repository function to the dto itself.

@RestApi(baseUrl: randomUserEndPoint)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET('/')
  Future<UserWrapper> getRandomUser();

  @POST('/')
  Future<void> submitForm(@Body() Map<String, dynamic> formData);

}
