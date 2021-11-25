import 'dart:async';

import 'package:flutter/material.dart';
import 'package:unsplash_pictures_bloc/api/picture_api.dart';
import 'package:unsplash_pictures_bloc/entitys/picture.dart';

class PictureListModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  late var _pictures = <Picture>[];

  var _totalPage;

  var _currentPage;

  bool _isLoadingInProgres = false;
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

  void clearPictureList() {
    _pictures = [];
  }

  // Future<void> _loadNextPage() async {
  //   if (_isLoadingInProgres || _currentPage >= _totalPage) return;
  //   _isLoadingInProgres = !_isLoadingInProgres;
  //   final _nextpage = _currentPage + 1;
  //   try {
  //     final responceMovies = await _loadMovies(_nextpage);
  //     //если и будет ощиька то только сверху и поля ниже не выполнятся
  //     _movies.addAll(responceMovies.movies);
  //     _currentPage = responceMovies.page;
  //     _totalPage = responceMovies.totalPages;
  //     _isLoadingInProgres = !_isLoadingInProgres;
  //     notifyListeners();
  //   } catch (e) {
  //     _isLoadingInProgres = !_isLoadingInProgres;
  //   }
  // }
}
