import 'package:freezed_annotation/freezed_annotation.dart';

part 'freezed_data_classes.freezed.dart';

@Freezed()
class LoginObject with _$LoginObject {
  const factory LoginObject(
    String username,
    String password,
  ) = _LoginObject;
}

@Freezed()
class RegisterObject with _$RegisterObject {
  const factory RegisterObject(
    String countryMobileCode,
    String username,
    String email,
    String password,
    String profilePicture,
  ) = _RegisterObject;
}
