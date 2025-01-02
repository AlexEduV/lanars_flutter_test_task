import 'package:dio/dio.dart';
import 'package:lanars_flutter_test_task/domain/models/picture_entry_wrapper.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'pictures_api_service.g.dart';

const picturesEndPoint = 'https://api.pexels.com/v1';

@RestApi(baseUrl: picturesEndPoint)
abstract class PicturesApiService {
  factory PicturesApiService(Dio dio, {String baseUrl}) = _PicturesApiService;

  @GET('/curated')
  Future<PictureEntryWrapper> getPictures(
      @Header('Authorization') String api,
      @Query('per_page') int perPage,
  );

}