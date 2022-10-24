import 'dart:async';

import 'package:analyzer/file_system/file_system.dart';
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
  void start() {
    // TODO: implement start
  }

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
  // TODO: implement outputIsUsernameValid
  Stream<bool> get outputIsUsernameValid => _usernameStreamController.stream.map((username) => _isUsernameValid(username));

  @override
  // TODO: implement outputErrorUsername
  Stream<String?> get outputErrorUsername => outputIsUsernameValid.map((isUsernameValid) => isUsernameValid ? null : AppStrings.usernameError);

  @override
  // TODO: implement outputIsEmailValid
  Stream<bool> get outputIsEmailValid => throw UnimplementedError();

  @override
  // TODO: implement outputErrorEmail
  Stream<String?> get outputErrorEmail => throw UnimplementedError();

  @override
  // TODO: implement outputIsMobileNumberValid
  Stream<bool> get outputIsMobileNumberValid => throw UnimplementedError();

  @override
  // TODO: implement outputErrorMobileNumber
  Stream<String?> get outputErrorMobileNumber => throw UnimplementedError();

  @override
  // TODO: implement outputIsPasswordValid
  Stream<bool> get outputIsPasswordValid => throw UnimplementedError();

  @override
  // TODO: implement outputErrorPassword
  Stream<String?> get outputErrorPassword => throw UnimplementedError();

  @override
  // TODO: implement outputIsProfilePictureValid
  Stream<File> get outputIsProfilePictureValid => throw UnimplementedError();

  @override
  register() {
    // TODO: implement register
    throw UnimplementedError();
  }

  // private methods
  bool _isUsernameValid(String username) => username.length >= 8;
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
