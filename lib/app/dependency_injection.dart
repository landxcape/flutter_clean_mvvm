import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_clean_mvvm/app/app_prefs.dart';
import 'package:flutter_clean_mvvm/data/data_source/remote_data_source.dart';
import 'package:flutter_clean_mvvm/data/network/app_api.dart';
import 'package:flutter_clean_mvvm/data/network/dio_factory.dart';
import 'package:flutter_clean_mvvm/data/network/network_info.dart';
import 'package:flutter_clean_mvvm/domain/repository/repository.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/repository/repository_impl.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  final sharedPrefs = await SharedPreferences.getInstance();

  // shared prefs instance
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  // app prefs instance
  instance.registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  // network info instance
  instance.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(DataConnectionChecker()));

  // dio factory
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  // app service client
  final dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  // remote data source
  instance.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl(instance()));

  // repository
  instance.registerLazySingleton<Repository>(() => RepositoryImpl(instance(), instance()));
  
}
