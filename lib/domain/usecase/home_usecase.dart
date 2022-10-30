// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import '../model/model.dart';
import '/data/network/failure.dart';
import '/domain/repository/repository.dart';
import '/domain/usecase/base_usecase.dart';

class HomeUseCase extends BaseUseCase<void, HomeObject> {
  final Repository _repository;
  HomeUseCase(this._repository);

  @override
  Future<Either<Failure, HomeObject>> execute(void input) async {
    return await _repository.getHome();
  }
}
