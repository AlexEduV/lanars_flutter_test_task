import 'package:lanars_flutter_test_task/domain/models/picture_entry.dart';
import 'package:lanars_flutter_test_task/domain/models/user.dart';

class GlobalMockStorage {
  //todo: the mock storage might need to be reworked to be more serious
  static late User user;
  static List<PictureEntry> results = [];
}