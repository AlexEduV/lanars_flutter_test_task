import 'package:dio/dio.dart';

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
        return response.data;
      }
      else {
        return 'Помилка відправки форми - ${response.statusCode}, ${response.statusMessage}';
      }

    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        return 'Помилка з\'єднання - Таймаут';
      }
      else if (e.type == DioExceptionType.badResponse) {
        return 'Помилка сервера - ${e.response?.statusCode}, ${e.response?.statusMessage}';
      }
    }

    return '';

  }

}