// ignore_for_file: public_member_api_docs, sort_constructors_first
class LoginRequest {
  String email;
  String password;
  String imei;
  String deviceType;

  LoginRequest(
    this.email,
    this.password,
    this.imei,
    this.deviceType,
  );
}

class RegisterRequest {
  String countryMobileCode;
  String username;
  String email;
  String password;
  String profilePicture;

  RegisterRequest(
    this.countryMobileCode,
    this.username,
    this.email,
    this.password,
    this.profilePicture,
  );
}
