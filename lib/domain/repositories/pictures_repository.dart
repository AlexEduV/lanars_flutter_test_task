import 'package:dio/dio.dart';

abstract class PicturesRepository {
  Future<String> getPictures(Dio client);
}