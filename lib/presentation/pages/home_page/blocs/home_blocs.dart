import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lanars_flutter_test_task/data/network/dio_client.dart';
import 'package:lanars_flutter_test_task/data/repositories/pictures_repository_impl.dart';
import 'package:lanars_flutter_test_task/data/storage/global_mock_storage.dart';
import 'package:lanars_flutter_test_task/domain/models/picture_entry.dart';
import 'package:lanars_flutter_test_task/presentation/pages/home_page/blocs/home_events.dart';
import 'package:lanars_flutter_test_task/presentation/pages/home_page/blocs/home_states.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<LoadingPicturesEvent>(_onLoadPictures);
  }

  Future<void> _onLoadPictures(LoadingPicturesEvent event, Emitter<HomeState> emit) async {

    emit(HomeLoading());
    try {
      await PicturesRepositoryImpl().getPictures(DioClient.client);
      final results = _groupPicturesByFirstLetter(GlobalMockStorage.results);
      emit(HomeLoaded(results));
    } catch (e) {
      emit(HomeError(e.toString()));
    }

  }

  //todo: there's an issue with either this algorithm, or in the UI;
  //when the item contains a new letter, the list will duplicate the item
  List<Map<String, dynamic>> _groupPicturesByFirstLetter(List<PictureEntry> pictures) {
    final grouped = <Map<String, dynamic>>[];
    String? lastLetter;

    for (final PictureEntry picture in pictures) {
      final letter = picture.photographerName[0].toUpperCase();
      if (letter != lastLetter) {
        // Add header entry
        grouped.add({'isHeader': true, 'letter': letter, 'picture': picture});
        lastLetter = letter;
      }
      // Add picture entry
      grouped.add({'isHeader': false, 'letter': letter, 'picture': picture});
    }

    return grouped;
  }

}
