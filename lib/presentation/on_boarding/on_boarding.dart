import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clean_mvvm/presentation/on_boarding/on_boarding_viewmodel.dart';
import 'package:flutter_clean_mvvm/presentation/resources/assets_manager.dart';
import 'package:flutter_clean_mvvm/presentation/resources/color_manager.dart';
import 'package:flutter_clean_mvvm/presentation/resources/routes_manager.dart';
import 'package:flutter_clean_mvvm/presentation/resources/strings_manager.dart';
import 'package:flutter_clean_mvvm/presentation/resources/values_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../domain/model.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final PageController _pageController = PageController(initialPage: 0);
  final OnBoardingViewModel _onBoardingViewModel = OnBoardingViewModel();

  _bind() {
    _onBoardingViewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _onBoardingViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SliderViewObject>(
      stream: _onBoardingViewModel.outputSliderViewObject,
      builder: (context, snapshot) {
        return _getContentWidget(snapshot.data);
      },
    );
  }

  Widget _getContentWidget(SliderViewObject? sliderViewObject) {
    if (sliderViewObject == null) {
      return Container();
    }
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        elevation: AppSize.s0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: ColorManager.white,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: sliderViewObject.numOfSlides,
        onPageChanged: (index) {
          _onBoardingViewModel.onPageChanged(index);
        },
        itemBuilder: (context, index) {
          return OnBoardingPage(sliderViewObject.sliderObject);
        },
      ),
      bottomSheet: Container(
        color: ColorManager.white,
        height: AppSize.s100,
        child: Column(children: [
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, Routes.loginRoute);
              },
              child: Text(
                AppStrings.skip,
                textAlign: TextAlign.end,
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
          ),
          // add layout for indicator and arrows
          _getBottomSheetWidget(sliderViewObject),
        ]),
      ),
    );
  }

  Widget _getBottomSheetWidget(SliderViewObject sliderViewObject) {
    return Container(
      color: ColorManager.primary,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        // left arrow
        Padding(
          padding: const EdgeInsets.all(AppPadding.p14),
          child: GestureDetector(
            onTap: () {
              // go to previous slide
              _pageController.animateToPage(
                _onBoardingViewModel.goPrevious(),
                duration: const Duration(milliseconds: DurationConstant.d300),
                curve: Curves.bounceInOut,
              );
            },
            child: SizedBox(
              height: AppSize.s20,
              width: AppSize.s20,
              child: SvgPicture.asset(ImageAssets.leftArrowIc),
            ),
          ),
        ),

        // circles indicator
        Row(
          children: [
            for (int i = 0; i < sliderViewObject.numOfSlides; i++)
              Padding(
                padding: const EdgeInsets.all(AppPadding.p8),
                child: _getCircleIndicator(i, sliderViewObject.currentIndex),
              ),
          ],
        ),

        // right arrow
        Padding(
          padding: const EdgeInsets.all(AppPadding.p14),
          child: GestureDetector(
            onTap: () {
              // go to next slide
              _pageController.animateToPage(
                _onBoardingViewModel.goNext(),
                duration: const Duration(milliseconds: DurationConstant.d300),
                curve: Curves.bounceInOut,
              );
            },
            child: SizedBox(
              height: AppSize.s20,
              width: AppSize.s20,
              child: SvgPicture.asset(ImageAssets.rightArrowIc),
            ),
          ),
        ),
      ]),
    );
  }

  Widget _getCircleIndicator(int index, int currentIndex) {
    if (index == currentIndex) {
      return SvgPicture.asset(ImageAssets.holowCircieIc); // selected slider
    }
    return SvgPicture.asset(ImageAssets.solidCircleIc); // selected slider
  }
}

class OnBoardingPage extends StatelessWidget {
  final SliderObject _sliderObject;
  const OnBoardingPage(this._sliderObject, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      const SizedBox(height: AppSize.s40),
      Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: Text(
          _sliderObject.title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: Text(
          _sliderObject.subTitle,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ),
      const SizedBox(height: AppSize.s60),
      SvgPicture.asset(_sliderObject.image),
    ]);
  }
}
