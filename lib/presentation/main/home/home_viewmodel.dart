import 'dart:async';
import 'dart:ffi';

import 'package:flutter_clean_mvvm/domain/model/model.dart';
import 'package:flutter_clean_mvvm/presentation/base/baseviewmodel.dart';
import 'package:flutter_clean_mvvm/presentation/common/state_renderer/state_renderer.dart';
import 'package:flutter_clean_mvvm/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rxdart/rxdart.dart';

import '../../../domain/usecase/home_usecase.dart';

class HomeViewModel extends BaseViewModel with HomeViewModelInputs, HomeViewModelOutputs {
  final HomeUseCase _homeUseCase;
  HomeViewModel(this._homeUseCase);

  final StreamController _bannersController = BehaviorSubject<List<BannerAd>>();
  final StreamController _servicesController = BehaviorSubject<List<Service>>();
  final StreamController _storesController = BehaviorSubject<List<Store>>();

  // inputs
  @override
  void start() {
    _getHome();
  }

  _getHome() async {
    inputState.add(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));

    (await _homeUseCase.execute(Void)).fold(
      (failure) {
        inputState.add(ErrorState(StateRendererType.fullScreenErrorState, failure.message));
      },
      (homeObject) {
        inputState.add(ContentState());

        inputBanners.add(homeObject.data.banners);
        inputServices.add(homeObject.data.services);
        inputStores.add(homeObject.data.stores);
      },
    );
  }

  @override
  void dispose() {
    _bannersController.close();
    _servicesController.close();
    _storesController.close();
  }

  @override
  Sink get inputBanners => _bannersController.sink;

  @override
  Sink get inputServices => _servicesController.sink;

  @override
  Sink get inputStores => _storesController.sink;

  // outputs
  @override
  Stream<List<BannerAd>> get outputBanners => _bannersController.stream.map((banner) => banner);

  @override
  Stream<List<Service>> get outputServices => _servicesController.stream.map((service) => service);

  @override
  Stream<List<Store>> get outputStores => _storesController.stream.map((store) => store);

  // private functions
}

abstract class HomeViewModelInputs {
  Sink get inputStores;
  Sink get inputServices;
  Sink get inputBanners;
}

abstract class HomeViewModelOutputs {
  Stream<List<Store>> get outputStores;
  Stream<List<Service>> get outputServices;
  Stream<List<BannerAd>> get outputBanners;
}
