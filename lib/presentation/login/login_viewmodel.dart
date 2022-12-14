// Dart imports:
import 'dart:async';

// Project imports:
import '/domain/usecase/login_usecase.dart';
import '/presentation/base/baseviewmodel.dart';
import '/presentation/common/freezed_data_classes.dart';
import '/presentation/common/state_renderer/state_renderer.dart';
import '/presentation/common/state_renderer/state_renderer_impl.dart';

class LoginViewModel extends BaseViewModel with LoginViewModelInputs, LoginViewModelOutputs {
  final StreamController _usernameStreamController = StreamController<String>.broadcast();
  final StreamController _passwordStreamController = StreamController<String>.broadcast();

  final StreamController _isAllInputsValidStreamController = StreamController<void>.broadcast();

  final StreamController isUserLoggedInSuccessfullyStreamController = StreamController<String>();

  LoginObject loginObject = const LoginObject('', '');

  final LoginUseCase _loginUseCase;
  LoginViewModel(this._loginUseCase);

  // inputs
  @override
  void dispose() {
    _usernameStreamController.close();
    _passwordStreamController.close();
    _isAllInputsValidStreamController.close();
    isUserLoggedInSuccessfullyStreamController.close();
  }

  @override
  void start() {
    // view tells state renderer to show content of the screen
    inputState.add(ContentState());
  }

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUsername => _usernameStreamController.sink;

  @override
  Sink get inputIsAllInputsValid => _isAllInputsValidStreamController.sink;

  @override
  login() async {
    inputState.add(LoadingState(stateRendererType: StateRendererType.popupLoadingState));

    (await _loginUseCase.execute(LoginUseCaseInput(
      loginObject.username,
      loginObject.password,
    )))
        .fold(
      (failure) {
        // left -> failure
        inputState.add(ErrorState(StateRendererType.popupErrorState, failure.message));
      },
      (data) {
        // right -> success (data)
        inputState.add(ContentState());

        // navigate to main screen after login
        isUserLoggedInSuccessfullyStreamController.add('TOKENtESTgotFromDataInLogin');
      },
    );
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(password: password); // data class operation same as kotlin
    _validate();
  }

  @override
  setUsername(String username) {
    inputUsername.add(username);
    loginObject = loginObject.copyWith(username: username); // data class operation same as kotlin
    _validate();
  }

  // outputs
  @override
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream.map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get outputIsUsernameValid => _usernameStreamController.stream.map((username) => _isUsernameValid(username));

  @override
  Stream<bool> get outputIsAllInputsValid => _isAllInputsValidStreamController.stream.map((_) => _isAllInputsValid());

// private functions
  _validate() {
    inputIsAllInputsValid.add(null);
  }

  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  bool _isUsernameValid(String username) {
    return username.isNotEmpty;
  }

  bool _isAllInputsValid() {
    return _isPasswordValid(loginObject.password) && _isUsernameValid(loginObject.username);
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
  Sink get inputIsAllInputsValid;
}

abstract class LoginViewModelOutputs {
  Stream<bool> get outputIsUsernameValid;
  Stream<bool> get outputIsPasswordValid;
  Stream<bool> get outputIsAllInputsValid;
}
