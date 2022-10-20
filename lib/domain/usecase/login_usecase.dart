import 'package:flutter_clean_mvvm/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_clean_mvvm/data/request/request.dart';
import 'package:flutter_clean_mvvm/domain/model/model.dart';
import 'package:flutter_clean_mvvm/domain/repository/repository.dart';
import 'package:flutter_clean_mvvm/domain/usecase/base_usecase.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput, Authentication> {
  final Repository _repository;
  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(LoginUseCaseInput input) async {
    await _repository.login(LoginRequest(
      input.email,
      input.password,
      'imei',
      'deviceType',
    ));
  }
}

class LoginUseCaseInput {
  String email;
  String password;
  LoginUseCaseInput(
    this.email,
    this.password,
  );
}
