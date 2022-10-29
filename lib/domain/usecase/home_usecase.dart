// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:flutter_clean_mvvm/data/network/failure.dart';
import 'package:flutter_clean_mvvm/domain/repository/repository.dart';
import 'package:flutter_clean_mvvm/domain/usecase/base_usecase.dart';
import '../model/model.dart';

class HomeUseCase extends BaseUseCase<void, HomeObject> {
  final Repository _repository;
  HomeUseCase(this._repository);

  @override
  Future<Either<Failure, HomeObject>> execute(void input) async {
    return await _repository.getHome();
  }
}
