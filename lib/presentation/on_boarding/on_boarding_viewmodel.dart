import 'package:flutter_clean_mvvm/presentation/base/baseviewmodel.dart';

class OnBoardingViewModel extends BaseViewModel with OnBoardingViewModelInputs, OnBoardingViewModelOutputs {
  // inputs
  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  void start() {
    // TODO: implement start
  }

  @override
  void goNext() {
    // TODO: implement goNext
  }

  @override
  void goPrevious() {
    // TODO: implement goPrevious
  }

  @override
  void onPageChanged(int index) {
    // TODO: implement onPageChanged
  }
}

// inputs mean the requests our viewmodel will receive from the view
abstract class OnBoardingViewModelInputs {
  void goNext(); // when user clicks on the right arrow or swap left
  void goPrevious(); // when user clicks on the left arrow or swap right
  void onPageChanged(int index);
}

// output mena the data/results that will be sent from viewmodel to view
abstract class OnBoardingViewModelOutputs {
  // TODO: implement onboarding view model outputs
}
