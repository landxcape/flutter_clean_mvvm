// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import '/data/network/failure.dart';
import '/domain/repository/repository.dart';
import '/domain/usecase/base_usecase.dart';

class ForgotPasswordUseCase implements BaseUseCase<String, String> {
  final Repository _repository;
  ForgotPasswordUseCase(this._repository);

  @override
  Future<Either<Failure, String>> execute(String input) async {
    return await _repository.forgotPassword(input);
  }
}
