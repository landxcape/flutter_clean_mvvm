import 'package:flutter_clean_mvvm/data/data_source/remote_data_source.dart';
import 'package:flutter_clean_mvvm/data/mapper/mapper.dart';
import 'package:flutter_clean_mvvm/data/network/error_handler.dart';
import 'package:flutter_clean_mvvm/data/network/network_info.dart';
import 'package:flutter_clean_mvvm/domain/model/model.dart';
import 'package:flutter_clean_mvvm/data/request/request.dart';
import 'package:flutter_clean_mvvm/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_clean_mvvm/domain/repository/repository.dart';

class RepositoryImpl extends Repository {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  RepositoryImpl(
    this._remoteDataSource,
    this._networkInfo,
  );

  @override
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        // it is safe to call api
        final response = await _remoteDataSource.login(loginRequest);

        if (response.status == ApiInternalStatus.success) {
          // success
          // return data
          // return either right
          return Right(response.toDomain());
        } else {
          // return business loginc error
          // return either left
          return Left(Failure(
            response.status ?? ApiInternalStatus.failure,
            response.message ?? ResponseMessage.defaultError,
          ));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return connection error
      return Left(DataSource.internalServerError.getFailure());
    }
  }
}
