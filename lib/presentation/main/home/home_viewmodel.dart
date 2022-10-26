import 'dart:async';

import 'package:flutter_clean_mvvm/domain/model/model.dart';
import 'package:flutter_clean_mvvm/presentation/base/baseviewmodel.dart';
import 'package:rxdart/rxdart.dart';

import '../../../domain/usecase/home_usecase.dart';

class HomeViewModel extends BaseViewModel {
  final HomeUseCase _homeUseCase;
  HomeViewModel(this._homeUseCase);

  final StreamController _bannersController = BehaviorSubject<List<BannerAd>>();
  final StreamController _servicesController = BehaviorSubject<List<Service>>();
  final StreamController _storesController = BehaviorSubject<List<Store>>();

  @override
  void start() {
    // TODO: implement start
  }

  @override
  void dispose() {
    _bannersController.close();
    _servicesController.close();
    _storesController.close();
  }
}
