import 'dart:convert';
import 'dart:io';

import 'package:unsplash_pictures_bloc/entitys/picture.dart';

// перечисление ошибок
enum ApiClientExceptionType { network, auth, other }

class ApiClientException implements Exception {
  final ApiClientExceptionType type;

  ApiClientException(this.type);
}

class ApiClient {
  final _client = HttpClient();
  static const _host =
      'https://api.unsplash.com/'; //куда мы юудем отправлять запросы все запросы начинаются с этого урл
  static const _clientId =
      '_qEQ9M6Q4v2I8KfqV2xdV7N_6F0fG8x1D6MaFIIl1I0'; // апи кей этот ключ в личном кабинете с помощью него можно работать с прогой

  Uri _makeUri(String path, [Map<String, dynamic>? parametrs]) {
    final uri = Uri.parse('$_host$path');
    if (parametrs != null) {
      return uri.replace(queryParameters: parametrs);
    } else {
      return uri;
    }
  }

  Future<T> _get<T>({
    required String path,
    required T Function(dynamic json) parser,
    Map<String, dynamic>? parametrs,
  }) async {
    final url = _makeUri(path, parametrs);
    try {
      final request = await _client.getUrl(url);
      final responce = await request.close();
      final dynamic json = (await responce.jsonDecode());
      // _validateResponse(responce, json);
      final result = parser(json);
      return result;
      // Вот сюда
    } on SocketException {
      // Если ошибка с сетью мы генерируем ощибку и выходим
      throw ApiClientException(ApiClientExceptionType.network);
    } on ApiClientException {
      // Ессли получаем нашу ощибку описанную через if то мы её просто пробрасываем наверх
      rethrow;
    } catch (e) {
      print(e);
      // и если случилось что не наша и не сокет то это другие ошибки
      throw ApiClientException(ApiClientExceptionType.other);
    }
  }

  Future<T> _post<T>(
    String path,
    Map<String, dynamic> bodyParametrs,
    T Function(dynamic json) parser, [
    Map<String, dynamic>? urlParametrs,
  ]) async {
    try {
      final url = _makeUri(path, urlParametrs);
      final request = await _client.postUrl(
        url,
      );
      request.headers.contentType = ContentType.json;
      request.write(jsonEncode(bodyParametrs));
      final responce = await request.close();
      final dynamic json = (await responce.jsonDecode());
      _validateResponse(responce, json);
      final result = parser(json);
      return result;
    } on SocketException {
      throw ApiClientException(ApiClientExceptionType.network);
    } on ApiClientException {
      rethrow;
    } catch (_) {
      throw ApiClientException(ApiClientExceptionType.other);
    }
  }

  void _validateResponse(HttpClientResponse responce, dynamic json) {
    if (responce.statusCode == 401) {
      final dynamic status = json['status_code'];
      final code = status is int ? status : 0;
      if (code == 30) {
        throw ApiClientException(ApiClientExceptionType.auth);
      } else {
        throw ApiClientException(ApiClientExceptionType.other);
      }
    }
  }

  Future<List<Picture>> getAllPicture(int page) async {
    // ignore: prefer_function_declarations_over_variables
    final parser = (dynamic json) {
      final jsonMap = json as List<dynamic>;
      final pictures = jsonMap
          .map((dynamic e) => Picture.fromJson(e as Map<String, dynamic>))
          .toList();

      return pictures;
    };
    final result = _get(
      path: 'photos/',
      parser: parser,
      parametrs: <String, dynamic>{
        'client_id': _clientId,
        'page': page.toString(),
        'per_page': 15.toString()
      },
    );
    return result;
  }
}

extension HttpClientResponseJsonDecode on HttpClientResponse {
  Future<dynamic> jsonDecode() async {
    return transform(utf8.decoder)
        .toList()
        .then((value) => value.join())
        .then<dynamic>((v) => json.decode(v));
  }
}
