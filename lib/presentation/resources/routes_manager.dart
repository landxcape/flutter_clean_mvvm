import 'package:flutter/material.dart';
import 'package:flutter_clean_mvvm/app/dependency_injection.dart';
import 'package:flutter_clean_mvvm/presentation/forgot_password/forgot_password.dart';
import 'package:flutter_clean_mvvm/presentation/login/login.dart';
import 'package:flutter_clean_mvvm/presentation/main/main_view.dart';
import 'package:flutter_clean_mvvm/presentation/on_boarding/on_boarding.dart';
import 'package:flutter_clean_mvvm/presentation/register/register.dart';
import 'package:flutter_clean_mvvm/presentation/resources/strings_manager.dart';

import 'package:flutter_clean_mvvm/presentation/splash/splash.dart';
import 'package:flutter_clean_mvvm/presentation/store_details/store_details.dart';

class Routes {
  static const String splashRoute = '/';
  static const String onBoardingRoute = '/onBoarding';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String forgetPasswordRoute = '/forgetPassword';
  static const String mainRoute = '/main';
  static const String storeDetailsRoute = '/storeDetails';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => const OnBoardingView());
      case Routes.loginRoute:
        initLoginModule();
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.registerRoute:
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case Routes.forgetPasswordRoute:
        initForgetPasswordModule();
        return MaterialPageRoute(builder: (_) => const ForgotPasswordView());
      case Routes.mainRoute:
        return MaterialPageRoute(builder: (_) => const MainView());
      case Routes.storeDetailsRoute:
        return MaterialPageRoute(builder: (_) => const StoreDetailsView());
      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.noRouteFound),
        ),
        body: const Center(child: Text(AppStrings.noRouteFound)),
      ),
    );
  }
}
