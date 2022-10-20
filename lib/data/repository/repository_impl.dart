import 'package:flutter_clean_mvvm/data/data_source/remote_data_source.dart';
import 'package:flutter_clean_mvvm/data/mapper/mapper.dart';
import 'package:flutter_clean_mvvm/data/network/network_info.dart';
import 'package:flutter_clean_mvvm/domain/model.dart';
import 'package:flutter_clean_mvvm/data/request/request.dart';
import 'package:flutter_clean_mvvm/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_clean_mvvm/domain/repository.dart';

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
      // it is safe to call api
      final response = await _remoteDataSource.login(loginRequest);

      if (response.status == 0) {
        // success
        // return data
        // return either right
        return Right(response.toDomain());
      } else {
        // return business loginc error
        // return either left
        return Left(Failure(409, response.message ?? 'We have biz error logic from API side'));
      }
    } else {
      // return connection error
      return Left(Failure(501, 'Please check your internet connection.'));
    }
  }
}
