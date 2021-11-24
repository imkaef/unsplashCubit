import 'dart:async';

import 'package:flutter/material.dart';
import 'package:unsplash_pictures_bloc/api/picture_api.dart';
import 'package:unsplash_pictures_bloc/entitys/picture.dart';

class PictureListModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  late var _pictures = <Picture>[];
  List<Picture> get pictures => List.unmodifiable(_pictures);

// если квери не пустое то вы возвращем поиск фильмов, если пустое то выводим список фильмов
  Future<List<Picture>> _loadPictures() async {
    return _apiClient.getAllPicture();
  }
  // Future<List<Picture>> _loadPictures() async {
  //   return _apiClient.getAllPicture();
  // }

  Future<void> loadPage() async {
    _pictures = await _loadPictures();
  }

  Future<void> addNextPage() async {
    final next = await _loadPictures();
    _pictures.addAll(next);
  }
}
