import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  @override
  Widget build(BuildContext context) {
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
        itemCount: _list.length,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          return OnBoardingPage(_list[index]);
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
          _getBottomSheetWidget(),
        ]),
      ),
    );
  }

  Widget _getBottomSheetWidget() {
    return Container(
      color: ColorManager.primary,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        // left arrow
        Padding(
          padding: const EdgeInsets.all(AppPadding.p14),
          child: GestureDetector(
            onTap: () {
              // go to next slide
              _pageController.animateToPage(
                _getPreviousIndex(),
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
            for (int i = 0; i < _list.length; i++)
              Padding(
                padding: const EdgeInsets.all(AppPadding.p8),
                child: _getCircleIndicator(i),
              ),
          ],
        ),

        // right arrow
        Padding(
          padding: const EdgeInsets.all(AppPadding.p14),
          child: GestureDetector(
            onTap: () {
              // go to previous slide
              _pageController.animateToPage(
                _getNextIndex(),
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

  int _getPreviousIndex() {
    
  }

  int _getNextIndex() {
    
  }

  Widget _getCircleIndicator(int index) {
    if (index == _currentIndex) {
      return SvgPicture.asset(ImageAssets.holowCircieIc); // selected slider
    }
    return SvgPicture.asset(ImageAssets.solidCircleIc); // selected slider
  }

  @override
  void dispose() {
    // TODO: viewmodel.dispose();
    super.dispose();
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
