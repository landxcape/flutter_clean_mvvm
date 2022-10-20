import 'package:dio/dio.dart';
import 'package:flutter_clean_mvvm/app/constants.dart';

const String applicationJson = 'application/json';
const String contentType = 'content-type';
const String accept = 'accept';
const String authorization = 'authorization';
const String defaultLanguage = 'language';

class DioFactory {
  Future<Dio> getDio() async {
    Dio dio = Dio();
    int _timeOut = 60000; // 1 minute

    Map<String, String> headers = {
      contentType: applicationJson,
      accept: applicationJson,
      authorization: Constants.token,
      defaultLanguage: 'en', // TODO: get language from app prefs
    };

    dio.options = BaseOptions(
      baseUrl: Constants.baseUrl,
      connectTimeout: _timeOut,
      receiveTimeout: _timeOut,
      headers: headers,
    );

    return dio;
  }
}
