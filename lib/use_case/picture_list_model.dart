import 'dart:async';

import 'package:flutter/material.dart';
import 'package:unsplash_pictures_bloc/api/picture_api.dart';
import 'package:unsplash_pictures_bloc/entitys/picture.dart';

class PictureListModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  late var _pictures = <Picture>[];
 // String? errorMessage = null;

  // int _totalPage = 0;

  var _currentPage = 0;

  bool _isLoadingInProgres = false;
  List<Picture> get pictures => List.unmodifiable(_pictures);

// если квери не пустое то вы возвращем поиск фильмов, если пустое то выводим список фильмов
  Future<void> _loadPictures(int page) async {
    final list = await _apiClient.getAllPicture(page);
    _pictures.addAll(list);
  }
  // Future<List<Picture>> _loadPictures() async {
  //   return _apiClient.getAllPicture();
  // }

  void clearPictureList() {
    _pictures = [];
    _currentPage = 0;
  }

  Future<void> loadNextPage() async {
    if (_isLoadingInProgres) return;
    _isLoadingInProgres = !_isLoadingInProgres;
    final _nextpage = _currentPage + 1;
    try {
      await _loadPictures(_nextpage);
      //если и будет ощиька то только сверху и поля ниже не выполнятся
      // _apiClient.getAllPicture(_nextpage);
      _currentPage = _nextpage;
      _isLoadingInProgres = !_isLoadingInProgres;
      notifyListeners();
    } on ApiClientException catch (e) {
      // errorMessage = e.toString();
      // print(errorMessage);
      _isLoadingInProgres = !_isLoadingInProgres;
      rethrow;
    }
  }

}
