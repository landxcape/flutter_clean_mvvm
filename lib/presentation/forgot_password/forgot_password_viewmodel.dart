import 'dart:async';

import 'package:flutter_clean_mvvm/domain/usecase/forgot_password_usecase.dart';
import 'package:flutter_clean_mvvm/presentation/base/baseviewmodel.dart';
import 'package:flutter_clean_mvvm/presentation/common/state_renderer/state_renderer.dart';
import 'package:flutter_clean_mvvm/presentation/common/state_renderer/state_renderer_impl.dart';

class ForgotPasswordViewModel extends BaseViewModel with ForgotPasswordViewModelInput, ForgotPasswordViewModelOutput {
  final StreamController _emailStreamController = StreamController<String>.broadcast();
  final StreamController _isAllInputValidStreamController = StreamController<void>.broadcast();

  final ForgotPasswordUseCase _forgotPasswordUseCase;

  ForgotPasswordViewModel(
    this._forgotPasswordUseCase,
  );

  String email = '';

  // inputs
  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  forgotPassword() async {
    inputState.add(
      LoadingState(stateRendererType: StateRendererType.popupLoadingState),
    );

    (await _forgotPasswordUseCase.execute(email)).fold(
      (failure) => ErrorState(StateRendererType.popupErrorState, failure.message),
      (data) => inputState.add(ContentState()),
    );
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    this.email = email;
    _validate();
  }

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get inputIsAllInputValid => _isAllInputValidStreamController.sink;

  // outputs
  @override
  void dispose() {
    _emailStreamController.close();
    _isAllInputValidStreamController.close();
  }

  @override
  Stream<bool> get outputIsAllInputValid => _isAllInputValidStreamController.stream.map((isAllInputValid) => _isAllInputValid());

  @override
  Stream<bool> get outputIsEmailValid => _emailStreamController.stream.map((email) => _isEmailValid(email));

  // pirvate functions
  _validate() {
    inputIsAllInputValid.add(null);
  }

  _isEmailValid(String email) {
    return email.isNotEmpty;
  }

  _isAllInputValid() {
    return _isEmailValid(email);
  }
}

abstract class ForgotPasswordViewModelInput {
  forgotPassword();

  setEmail(String email);

  Sink get inputEmail;

  Sink get inputIsAllInputValid;
}

abstract class ForgotPasswordViewModelOutput {
  Stream<bool> get outputIsEmailValid;

  Stream<bool> get outputIsAllInputValid;
}
