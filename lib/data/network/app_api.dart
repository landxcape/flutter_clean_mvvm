import 'package:dio/dio.dart';
import 'package:flutter_clean_mvvm/app/constants.dart';
import 'package:flutter_clean_mvvm/data/responses/responses.dart';
import 'package:retrofit/http.dart';

part 'app_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @POST('/customers/login')
  Future<AuthenticationResponse> login();
}
