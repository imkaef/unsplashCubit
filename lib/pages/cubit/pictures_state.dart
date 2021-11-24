part of 'pictures_cubit.dart';

@immutable
abstract class PicturesState {}

class PicturesInitial extends PicturesState {}

class PicturesLoadedState extends PicturesState {
  final List<Picture> pictures;
  PicturesLoadedState(this.pictures);
}

class PicturesErrorState extends PicturesState {
  final String errorMessage;

  PicturesErrorState(this.errorMessage);
}
