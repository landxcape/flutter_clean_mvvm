// Dart imports:
import 'dart:async';

// Package imports:
import 'package:analyzer/file_system/file_system.dart';

// Project imports:
import '/app/functions.dart';
import '/domain/usecase/register_usecase.dart';
import '/presentation/base/baseviewmodel.dart';
import '/presentation/common/freezed_data_classes.dart';
import '/presentation/common/state_renderer/state_renderer.dart';
import '/presentation/common/state_renderer/state_renderer_impl.dart';
import '/presentation/resources/strings_manager.dart';

class RegisterViewModel extends BaseViewModel with RegisterViewModelInput, RegisterViewModelOutput {
  final StreamController _mobileNumberStreamController = StreamController<String>.broadcast();
  final StreamController _usernameStreamController = StreamController<String>.broadcast();
  final StreamController _emailStreamController = StreamController<String>.broadcast();
  final StreamController _passwordStreamController = StreamController<String>.broadcast();
  final StreamController _profilePictureStreamController = StreamController<File>.broadcast();

  final StreamController _isAllInputsValidStreamController = StreamController<void>.broadcast();

  final RegisterUseCase _registerUseCase;

  RegisterObject registerViewObject = const RegisterObject('', '', '', '', '', '');

  RegisterViewModel(this._registerUseCase);

  // inputs
  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  register() async {
    inputState.add(LoadingState(stateRendererType: StateRendererType.popupLoadingState));

    (await _registerUseCase.execute(RegisterUseCaseInput(
      registerViewObject.mobileNumber,
      registerViewObject.countryCode,
      registerViewObject.username,
      registerViewObject.email,
      registerViewObject.password,
      registerViewObject.profilePicture,
    )))
        .fold(
      (failure) {
        inputState.add(ErrorState(StateRendererType.popupErrorState, failure.message));
      },
      (data) {
        inputState.add(ContentState());
      },
    );
  }

  @override
  void dispose() {
    _mobileNumberStreamController.close();
    _usernameStreamController.close();
    _emailStreamController.close();
    _passwordStreamController.close();
    _profilePictureStreamController.close();
    _isAllInputsValidStreamController.close();
  }

  @override
  setUsername(String username) {
    registerViewObject = registerViewObject.copyWith(username: _isUsernameValid(username) ? username : '');
    _validate();
  }

  @override
  setMobileNumber(String mobileNumber) {
    registerViewObject = registerViewObject.copyWith(mobileNumber: _isMobileNumberValid(mobileNumber) ? mobileNumber : '');
    _validate();
  }

  @override
  setCountryCode(String countryCode) {
    registerViewObject = registerViewObject.copyWith(countryCode: _isCountryCodeValid(countryCode) ? countryCode : '');
    _validate();
  }

  @override
  setEmail(String email) {
    registerViewObject = registerViewObject.copyWith(email: isEmailValid(email) ? email : '');
    _validate();
  }

  @override
  setPassword(String password) {
    registerViewObject = registerViewObject.copyWith(password: _isPasswordValid(password) ? password : '');
    _validate();
  }

  @override
  setProfilePicture(File profilePicture) {
    registerViewObject = registerViewObject.copyWith(profilePicture: _isProfilePictureValid(profilePicture) ? profilePicture.path : '');
    _validate();
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

  @override
  Sink get inputAllInputsValid => _isAllInputsValidStreamController.sink;

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
  Stream<bool> get outputIsAllInputsValid => _isAllInputsValidStreamController.stream.map((_) => _isAllInputsValid());

  // private methods
  bool _isUsernameValid(String username) => username.length >= 8;
  bool _isMobileNumberValid(String mobileNumber) => mobileNumber.length == 10;
  bool _isPasswordValid(String password) => password.length >= 8;
  bool _isCountryCodeValid(String countryCode) => countryCode.isNotEmpty;
  bool _isProfilePictureValid(File file) => file.path.isNotEmpty;
  bool _isAllInputsValid() =>
      registerViewObject.profilePicture.isNotEmpty &&
      registerViewObject.email.isNotEmpty &&
      registerViewObject.password.isNotEmpty &&
      registerViewObject.mobileNumber.isNotEmpty &&
      registerViewObject.username.isNotEmpty &&
      registerViewObject.countryCode.isNotEmpty;

  _validate() => inputAllInputsValid.add(null);
}

abstract class RegisterViewModelInput {
  register();

  setUsername(String username);
  setMobileNumber(String mobileNumber);
  setCountryCode(String countryCode);
  setEmail(String email);
  setPassword(String password);
  setProfilePicture(File profilePicture);

  Sink get inputUsername;

  Sink get inputMobileNumber;

  Sink get inputEmail;

  Sink get inputPassword;

  Sink get inputProfilePicutre;

  Sink get inputAllInputsValid;
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

  Stream<bool> get outputIsAllInputsValid;
}
