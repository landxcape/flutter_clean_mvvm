// Package imports:
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

// Project imports:
import 'package:flutter_clean_mvvm/app/constants.dart';
import 'package:flutter_clean_mvvm/data/responses/responses.dart';

part 'app_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @POST('/customers/login')
  Future<AuthenticationResponse> login(
    @Field('email') String email,
    @Field('password') String password,
    @Field('imei') String imei,
    @Field('deviceType') String deviceType,
  );

  @POST('/customers/forgotPassword')
  Future<ForgotPasswordResponse> forgotPassword(
    @Field('email') String email,
  );

  @POST('/customers/register')
  Future<AuthenticationResponse> register(
    @Field('country_code') String countryCode,
    @Field('username') String username,
    @Field('email') String email,
    @Field('password') String password,
    @Field('profile_picture') String profilePicture,
  );
}
