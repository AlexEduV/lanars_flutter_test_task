import 'package:dio/dio.dart';
import 'package:lanars_flutter_test_task/data/network/dio_client.dart';
import 'package:lanars_flutter_test_task/data/services/pictures_api_service.dart';
import 'package:lanars_flutter_test_task/data/storage/global_mock_storage.dart';
import 'package:lanars_flutter_test_task/domain/models/picture_entry.dart';
import 'package:lanars_flutter_test_task/domain/repositories/pictures_repository.dart';

class PicturesRepositoryImpl implements PicturesRepository {

  @override
  Future<String> getPictures(Dio client) async {

    try {

      //get data
      final service = PicturesApiService(client);
      final response = await service.getPictures(api);

      //sort the data by photographer's name
      final List<PictureEntry> sortedResults = response.photos
        ..sort((a, b) => a.photographerName.compareTo(b.photographerName));

      //store the results in the mock storage
      GlobalMockStorage.results = sortedResults;

    } on DioException catch (e) {
      DioClient.handleError(e);
    }

    return '';
  }

}