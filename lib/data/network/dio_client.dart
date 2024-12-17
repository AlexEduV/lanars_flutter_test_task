import 'package:dio/dio.dart';
import 'package:lanars_flutter_test_task/domain/usecases/get_pictures_usecase.dart';
import 'package:lanars_flutter_test_task/domain/usecases/get_random_person_usecase.dart';

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
      processPersonResponse(response);

    } on DioException catch (e) {
      DioClient._handleError(e);
    }

    return '';

  }

  static Future<String> getPictures() async {

    try {

      final response = await client.get(picturesEndPoint,
          options: Options(
            headers: {
              'Authorization': api
            }
          ),
      );

      processImagesResponse(response);

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
