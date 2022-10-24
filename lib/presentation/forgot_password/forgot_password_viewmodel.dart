import 'dart:async';

import 'package:flutter_clean_mvvm/domain/usecase/forgot_password_usecase.dart';
import 'package:flutter_clean_mvvm/presentation/base/baseviewmodel.dart';
import 'package:flutter_clean_mvvm/presentation/common/state_renderer/state_renderer.dart';
import 'package:flutter_clean_mvvm/presentation/common/state_renderer/state_renderer_impl.dart';

import '../../app/functions.dart';

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
      (failure) => inputState.add(ErrorState(StateRendererType.popupErrorState, failure.message)),
      (supportMessage) => inputState.add(SuccessState(supportMessage)),
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
  Stream<bool> get outputIsEmailValid => _emailStreamController.stream.map((email) => isEmailValid(email));

  // pirvate functions
  _validate() {
    inputIsAllInputValid.add(null);
  }

  _isAllInputValid() {
    return isEmailValid(email);
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
