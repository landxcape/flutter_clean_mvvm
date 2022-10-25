// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '/app/app_prefs.dart';
import '/app/dependency_injection.dart';
import '/presentation/resources/assets_manager.dart';
import '/presentation/resources/color_manager.dart';
import '/presentation/resources/routes_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;
  final AppPreferences _appPreferences = instance<AppPreferences>();

  _startDelay() {
    _timer = Timer(const Duration(seconds: 2), _goNext);
  }

  _goNext() async {
    _appPreferences.isUserLoggedIn().then((isUserLoggedIn) {
      if (isUserLoggedIn) {
        // navigate to main screen
        Navigator.pushReplacementNamed(context, Routes.mainRoute);
      } else {
        _appPreferences.isOnboardingScreenViewed().then((isOnboardingScreenViewed) {
          if (isOnboardingScreenViewed) {
            Navigator.pushReplacementNamed(context, Routes.loginRoute);
          } else {
            Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
          }
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: const Center(child: Image(image: AssetImage(ImageAssets.splashLogo))),
    );
  }
}
