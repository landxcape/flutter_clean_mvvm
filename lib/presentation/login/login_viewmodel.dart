import 'dart:async';

import 'package:flutter_clean_mvvm/presentation/base/baseviewmodel.dart';

class LoginViewModel extends BaseViewModel with LoginViewModelInputs, LoginViewModelOutputs {
  final StreamController _usernameStreamController = StreamController<String>.broadcast();
  final StreamController _passwordStreamController = StreamController<String>.broadcast();

  @override
  void dispose() {
    _usernameStreamController.close();
    _passwordStreamController.close();
  }

  @override
  void start() {
    // TODO: implement start
  }

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUsername => _usernameStreamController.sink;

  @override
  login() {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
  }

  @override
  setUsername(String username) {
    inputUsername.add(username);
  }

  @override
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream.map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get outputIsUsernameValid => _usernameStreamController.stream.map((username) => _isUsernameValid(username));

  // private functions
  _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  _isUsernameValid(String username) {
    return username.isNotEmpty;
  }
}

abstract class LoginViewModelInputs {
  // three funcitons for actions
  setUsername(String username);
  setPassword(String password);
  login();

  // two sinks
  Sink get inputUsername;
  Sink get inputPassword;
}

abstract class LoginViewModelOutputs {
  Stream<bool> get outputIsUsernameValid;
  Stream<bool> get outputIsPasswordValid;
}
