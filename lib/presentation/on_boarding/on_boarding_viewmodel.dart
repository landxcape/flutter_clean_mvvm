import 'dart:async';

import 'package:flutter_clean_mvvm/domain/model.dart';
import 'package:flutter_clean_mvvm/presentation/base/baseviewmodel.dart';

import '../resources/assets_manager.dart';
import '../resources/strings_manager.dart';

class OnBoardingViewModel extends BaseViewModel with OnBoardingViewModelInputs, OnBoardingViewModelOutputs {
  //stream controllers
  final StreamController _streamController = StreamController<SliderViewObject>();

  late final List<SliderObject> _list;
  int _currentIndex = 0;

  // inputs
  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    _list = _getSliderData();
    // send slider data to view
    _postDataToView();
  }

  @override
  void goNext() {
    int nextIndex = _currentIndex++;
    if (nextIndex >= _list.length - 1) {
      _currentIndex = 0; // infinite loop to go to the start slider list
    }
    _postDataToView();
  }

  @override
  void goPrevious() {
    int previousIndex = _currentIndex--;
    if (previousIndex <= 0) {
      _currentIndex = _list.length - 1; // infinite loop to go to the last slider list
    }
    _postDataToView();
  }

  @override
  void onPageChanged(int index) {
    _currentIndex = index;
    _postDataToView();
  }

  @override
  // TODO: implement inputSliderViewObject
  Sink get inputSliderViewObject => _streamController.sink;

  // outputs
  @override
  // TODO: implement outputSliderViewObject
  Stream<SliderViewObject> get outputSliderViewObject => _streamController.stream.map((sliderViewObject) => sliderViewObject);

  // private functions
  List<SliderObject> _getSliderData() => [
        SliderObject(AppStrings.onBoardingTitle1, AppStrings.onBoardingSubTitle1, ImageAssets.onboardingLogo1),
        SliderObject(AppStrings.onBoardingTitle2, AppStrings.onBoardingSubTitle2, ImageAssets.onboardingLogo2),
        SliderObject(AppStrings.onBoardingTitle3, AppStrings.onBoardingSubTitle3, ImageAssets.onboardingLogo3),
        SliderObject(AppStrings.onBoardingTitle4, AppStrings.onBoardingSubTitle4, ImageAssets.onboardingLogo4),
      ];

  _postDataToView() {
    inputSliderViewObject.add(SliderViewObject(_list[_currentIndex], _list.length, _currentIndex));
  }
}

// inputs mean the requests our viewmodel will receive from the view
abstract class OnBoardingViewModelInputs {
  void goNext(); // when user clicks on the right arrow or swap left
  void goPrevious(); // when user clicks on the left arrow or swap right
  void onPageChanged(int index);

  Sink get inputSliderViewObject; // method to add data to the stream - stream input
}

// output mena the data/results that will be sent from viewmodel to view
abstract class OnBoardingViewModelOutputs {
  Stream<SliderViewObject> get outputSliderViewObject;
}

class SliderViewObject {
  SliderObject sliderObject;
  int numOfSlides;
  int currentIndex;

  SliderViewObject(this.sliderObject, this.numOfSlides, this.currentIndex);
}
