// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import '../data_source/local_data_source.dart';
import '/data/data_source/remote_data_source.dart';
import '/data/mapper/mapper.dart';
import '/data/network/error_handler.dart';
import '/data/network/failure.dart';
import '/data/network/network_info.dart';
import '/data/request/request.dart';
import '/domain/model/model.dart';
import '/domain/repository/repository.dart';

class RepositoryImpl extends Repository {
  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  RepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
    this._networkInfo,
  );

  @override
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.login(loginRequest);
        // it is safe to call api

        if (response.status == ApiInternalStatus.success) {
          // success
          // return data
          // return either right
          return Right(response.toDomain());
        } else {
          // return business loginc error
          // return either left
          return Left(Failure(
            response.status ?? ResponseCode.defaultError,
            response.message ?? ResponseMessage.defaultError,
          ));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return connection error
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, String>> forgotPassword(String email) async {
    if (!(await _networkInfo.isConnected)) {
      return Left(DataSource.noInternetConnection.getFailure());
    }
    try {
      final response = await _remoteDataSource.forgotPassword(email);

      if (response.status == ApiInternalStatus.success) {
        return Right(response.toDomain());
      }

      return Left(Failure(
        response.status ?? ResponseCode.defaultError,
        response.message ?? ResponseMessage.defaultError,
      ));
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, Authentication>> register(RegisterRequest registerRequest) async {
    if (!(await _networkInfo.isConnected)) {
      return Left(DataSource.noInternetConnection.getFailure());
    }
    try {
      final response = await _remoteDataSource.register(registerRequest);

      if (response.status == ApiInternalStatus.success) {
        return Right(response.toDomain());
      }

      return Left(Failure(
        response.status ?? ResponseCode.defaultError,
        response.message ?? ResponseMessage.defaultError,
      ));
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, HomeObject>> getHome() async {
    try {
      final response = await _localDataSource.getHome();
      return Right(response.toDomain());
    } catch (cacheError) {
      if (!(await _networkInfo.isConnected)) {
        return Left(DataSource.noInternetConnection.getFailure());
      }
      try {
        final response = await _remoteDataSource.getHome();

        if (response.status == ApiInternalStatus.success) {
          _localDataSource.saveHomeToCache(response);
          return Right(response.toDomain());
        }

        return Left(Failure(
          response.status ?? ResponseCode.defaultError,
          response.message ?? ResponseMessage.defaultError,
        ));
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    }
  }

  @override
  Future<Either<Failure, StoreDetails>> getStoreDetails() async {
    try {
      final response = await _localDataSource.getStoreDetails();
      return Right(response.toDomain());
    } catch (cacheError) {
      if (!(await _networkInfo.isConnected)) {
        return Left(DataSource.noInternetConnection.getFailure());
      }
      try {
        final response = await _remoteDataSource.getStoreDetails();

        if (response.status == ApiInternalStatus.success) {
          _localDataSource.saveStoreDetailsToCache(response);
          return Right(response.toDomain());
        }

        return Left(Failure(
          response.status ?? ResponseCode.defaultError,
          response.message ?? ResponseMessage.defaultError,
        ));
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    }
  }
}
