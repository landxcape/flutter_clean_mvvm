// Dart imports:
import 'dart:async';

// Package imports:
import 'package:easy_localization/easy_localization.dart';

// Project imports:
import '../resources/assets_manager.dart';
import '../resources/strings_manager.dart';
import '/domain/model/model.dart';
import '/presentation/base/baseviewmodel.dart';

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
  int goNext() {
    int nextIndex = _currentIndex++;
    if (nextIndex >= _list.length - 1) {
      _currentIndex = 0; // infinite loop to go to the start slider list
    }

    return _currentIndex;
  }

  @override
  int goPrevious() {
    int previousIndex = _currentIndex--;
    if (previousIndex <= 0) {
      _currentIndex = _list.length - 1; // infinite loop to go to the last slider list
    }

    return _currentIndex;
  }

  @override
  void onPageChanged(int index) {
    _currentIndex = index;
    _postDataToView();
  }

  @override
  Sink get inputSliderViewObject => _streamController.sink;

  // outputs
  @override
  Stream<SliderViewObject> get outputSliderViewObject => _streamController.stream.map((sliderViewObject) => sliderViewObject);

  // private functions
  List<SliderObject> _getSliderData() => [
        SliderObject(AppStrings.onBoardingTitle1.tr(), AppStrings.onBoardingSubTitle1.tr(), ImageAssets.onboardingLogo1),
        SliderObject(AppStrings.onBoardingTitle2.tr(), AppStrings.onBoardingSubTitle2.tr(), ImageAssets.onboardingLogo2),
        SliderObject(AppStrings.onBoardingTitle3.tr(), AppStrings.onBoardingSubTitle3.tr(), ImageAssets.onboardingLogo3),
        SliderObject(AppStrings.onBoardingTitle4.tr(), AppStrings.onBoardingSubTitle4.tr(), ImageAssets.onboardingLogo4),
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
