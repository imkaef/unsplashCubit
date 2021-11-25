import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:unsplash_pictures_bloc/api/picture_api.dart';
import 'package:unsplash_pictures_bloc/entitys/picture.dart';
import 'package:unsplash_pictures_bloc/use_case/picture_list_model.dart';

part 'pictures_state.dart';

class PicturesCubit extends Cubit<PicturesState> {
  PicturesCubit() : super(PicturesInitial());

  final model = PictureListModel();

  Future<void> loadPictures() async {
    try {
      model.clearPictureList();
      // await Future.delayed(const Duration(seconds: 3));
      await model.loadPage();
      // if (model.pictures.isEmpty) return;
      emit(PicturesLoadedState(model.pictures));
    } on ApiClientException {
      emit(PicturesErrorState('sorry we cant download news'));
    }
    return;
  }

  Future<void> addPicture() async {
    try {
   //   emit(PicturesInitial());
      // await Future.delayed(const Duration(seconds: 3));
      await model.addNextPage();
      // if (model.pictures.isEmpty) return;
    } on ApiClientException {
      emit(PicturesErrorState('sorry we cant download news'));
    }
    return;
  }
}
