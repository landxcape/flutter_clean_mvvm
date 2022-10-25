// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import '../../data/network/failure.dart';

abstract class BaseUseCase<In, Out> {
  Future<Either<Failure, Out>> execute(In input);
}
