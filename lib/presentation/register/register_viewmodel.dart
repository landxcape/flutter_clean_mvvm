import 'dart:async';

import 'package:analyzer/file_system/file_system.dart';
import 'package:flutter_clean_mvvm/app/functions.dart';
import 'package:flutter_clean_mvvm/domain/usecase/register_usecase.dart';
import 'package:flutter_clean_mvvm/presentation/base/baseviewmodel.dart';
import 'package:flutter_clean_mvvm/presentation/resources/strings_manager.dart';

class RegisterViewModel extends BaseViewModel with RegisterViewModelInput, RegisterViewModelOutput {
  final StreamController _mobileNumberStreamController = StreamController<String>.broadcast();
  final StreamController _usernameStreamController = StreamController<String>.broadcast();
  final StreamController _emailStreamController = StreamController<String>.broadcast();
  final StreamController _passwordStreamController = StreamController<String>.broadcast();
  final StreamController _profilePictureStreamController = StreamController<File>.broadcast();

  final StreamController _isAllInputsValid = StreamController<void>.broadcast();

  final RegisterUseCase _registerUseCase;
  RegisterViewModel(this._registerUseCase);

  // inputs
  @override
  void start() {}

  @override
  void dispose() {
    _mobileNumberStreamController.close();
    _usernameStreamController.close();
    _emailStreamController.close();
    _passwordStreamController.close();
    _profilePictureStreamController.close();
    _isAllInputsValid.close();
  }

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get inputMobileNumber => _mobileNumberStreamController.sink;

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputProfilePicutre => _profilePictureStreamController.sink;

  @override
  Sink get inputUsername => _usernameStreamController.sink;

  // outputs
  @override
  Stream<bool> get outputIsUsernameValid => _usernameStreamController.stream.map((username) => _isUsernameValid(username));
  @override
  Stream<String?> get outputErrorUsername => outputIsUsernameValid.map((isUsernameValid) => isUsernameValid ? null : AppStrings.invalidUsername);

  @override
  Stream<bool> get outputIsEmailValid => _emailStreamController.stream.map((email) => isEmailValid(email));
  @override
  Stream<String?> get outputErrorEmail => outputIsEmailValid.map((isEmailValid) => isEmailValid ? null : AppStrings.invalidEmail);

  @override
  Stream<bool> get outputIsMobileNumberValid => _mobileNumberStreamController.stream.map((mobileNumber) => _isMobileNumberValid(mobileNumber));
  @override
  Stream<String?> get outputErrorMobileNumber => outputIsMobileNumberValid.map((isMNValid) => isMNValid ? null : AppStrings.invalidMobileNumber);

  @override
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream.map((password) => _isPasswordValid(password));
  @override
  Stream<String?> get outputErrorPassword => outputIsPasswordValid.map((isPasswordValid) => isPasswordValid ? null : AppStrings.invalidPassword);

  @override
  Stream<File> get outputIsProfilePictureValid => _profilePictureStreamController.stream.map((file) => file);

  @override
  register() {
    // TODO: implement register
    throw UnimplementedError();
  }

  // private methods
  bool _isUsernameValid(String username) => username.length >= 8;
  bool _isMobileNumberValid(String mobileNumber) => mobileNumber.length == 10;
  bool _isPasswordValid(String password) => password.length >= 8;
}

abstract class RegisterViewModelInput {
  register();

  Sink get inputUsername;

  Sink get inputMobileNumber;

  Sink get inputEmail;

  Sink get inputPassword;

  Sink get inputProfilePicutre;
}

abstract class RegisterViewModelOutput {
  Stream<bool> get outputIsUsernameValid;
  Stream<String?> get outputErrorUsername;

  Stream<bool> get outputIsMobileNumberValid;
  Stream<String?> get outputErrorMobileNumber;

  Stream<bool> get outputIsEmailValid;
  Stream<String?> get outputErrorEmail;

  Stream<bool> get outputIsPasswordValid;
  Stream<String?> get outputErrorPassword;

  Stream<File> get outputIsProfilePictureValid;
}
