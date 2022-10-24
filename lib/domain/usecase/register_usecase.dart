import 'package:flutter_clean_mvvm/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_clean_mvvm/data/request/request.dart';
import 'package:flutter_clean_mvvm/domain/model/model.dart';
import 'package:flutter_clean_mvvm/domain/repository/repository.dart';
import 'package:flutter_clean_mvvm/domain/usecase/base_usecase.dart';

class RegisterUseCase implements BaseUseCase<RegisterUseCaseInput, Authentication> {
  final Repository _repository;
  RegisterUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(RegisterUseCaseInput input) async {
    return await _repository.register(RegisterRequest(
      input.countryMobileCode,
      input.username,
      input.email,
      input.password,
      input.profilePicture,
    ));
  }
}

class RegisterUseCaseInput {
  String countryMobileCode;
  String username;
  String email;
  String password;
  String profilePicture;

  RegisterUseCaseInput(
    this.countryMobileCode,
    this.username,
    this.email,
    this.password,
    this.profilePicture,
  );
}
