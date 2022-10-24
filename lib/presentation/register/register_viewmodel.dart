import 'dart:async';

import 'package:analyzer/file_system/file_system.dart';
import 'package:flutter_clean_mvvm/presentation/base/baseviewmodel.dart';

class RegisterViewModel extends BaseViewModel {
  final StreamController _mobileNumberStreamController = StreamController<String>.broadcast();
  final StreamController _usernameStreamController = StreamController<String>.broadcast();
  final StreamController _emailStreamController = StreamController<String>.broadcast();
  final StreamController _passwordStreamController = StreamController<String>.broadcast();
  final StreamController _profilePictureStreamController = StreamController<File>.broadcast();

  final StreamController _isAllInputsValid = StreamController<void>.broadcast();

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
  Stream<String> get outputErrorUsername;

  Stream<bool> get outputIsMobileNumberValid;
  Stream<String> get outputErrorMobileNumber;

  Stream<bool> get outputIsEmailValid;
  Stream<String> get outputErrorEmail;

  Stream<bool> get outputIsPasswordValid;
  Stream<String> get outputErrorPassword;

  Stream<File> get outputIsProfilePictureValid;
}
