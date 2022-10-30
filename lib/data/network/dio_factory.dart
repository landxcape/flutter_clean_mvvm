// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

// Project imports:
import '/app/app_prefs.dart';
import '/app/constants.dart';

const String applicationJson = 'application/json';
const String contentType = 'content-type';
const String accept = 'accept';
const String authorization = 'authorization';
const String defaultLanguage = 'language';

class DioFactory {
  final AppPreferences _appPreferences;

  DioFactory(this._appPreferences);

  Future<Dio> getDio() async {
    Dio dio = Dio();
    int timeOut = 60000; // 1 minute
    String language = await _appPreferences.getAppLanguage();
    String token = await _appPreferences.getToken();

    Map<String, String> headers = {
      contentType: applicationJson,
      accept: applicationJson,
      authorization: token,
      defaultLanguage: language,
    };

    dio.options = BaseOptions(
      baseUrl: Constants.baseUrl,
      connectTimeout: timeOut,
      receiveTimeout: timeOut,
      headers: headers,
    );

    if (kReleaseMode) {
      // print('Release Mode no logs');
    } else {
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ));
    }

    return dio;
  }
}
