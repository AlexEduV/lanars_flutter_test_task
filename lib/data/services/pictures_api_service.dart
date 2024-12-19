import 'package:dio/dio.dart';
import 'package:lanars_flutter_test_task/domain/models/picture_entry.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'pictures_api_service.g.dart';

const picturesEndPoint = 'https://api.pexels.com/v1/curated?per_page=50';
const api = 'd0K2cyjHJ01jpHmINGkSZyoyrZ6CNxDUcsECbOdTzMeDG0AZpJteBDjp'; // use your own here;

@RestApi(baseUrl: picturesEndPoint)
abstract class PicturesApiService {
  factory PicturesApiService(Dio dio, {String baseUrl}) = _PicturesApiService;

  @GET('/')
  Future<PictureEntry> getPictures(@Header('Authorisation') String api);

}