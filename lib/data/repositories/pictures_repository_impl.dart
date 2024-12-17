import 'package:dio/dio.dart';
import 'package:lanars_flutter_test_task/data/network/dio_client.dart';
import 'package:lanars_flutter_test_task/domain/repositories/pictures_repository.dart';
import 'package:lanars_flutter_test_task/domain/usecases/get_pictures_usecase.dart';

class PicturesRepositoryImpl implements PicturesRepository {

  //todo: use retrofit as per project requirements

  final picturesEndPoint = 'https://api.pexels.com/v1/curated?per_page=50';
  final api = 'd0K2cyjHJ01jpHmINGkSZyoyrZ6CNxDUcsECbOdTzMeDG0AZpJteBDjp'; // use your own here;

  @override
  Future<String> getPictures() async {

    try {

      final response = await DioClient.client.get(picturesEndPoint,
        options: Options(
            headers: {
              'Authorization': api
            }
        ),
      );

      processImagesResponse(response);

    } on DioException catch (e) {
      DioClient.handleError(e);
    }

    return '';
  }

}