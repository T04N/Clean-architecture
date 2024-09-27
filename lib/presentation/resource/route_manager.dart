import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../forgot_password/forgotpass.dart';
import '../login/login.dart';
import '../main/mainRoute.dart';
import '../onboardiing/onboarding.dart';
import '../register/register.dart';
import '../splash/splash.dart';
import '../storeDetails/storeDetail.dart';

class Routes {
  static const String splashRoute = "/";
  static const String onBoardingRoute = "/onBoarding";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String forgotPassRoute = "/forgotPassword";
  static const String mainRoute = "/main";
  static const String storeDetailRoute = "/storeDetails";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => SplashView());
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => LoginView());
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => onboardingView());
      case Routes.registerRoute:
        return MaterialPageRoute(builder: (_) => registerView());
      case Routes.forgotPassRoute:
        return MaterialPageRoute(builder: (_) => ForgotpassView());
      case Routes.mainRoute:
        return MaterialPageRoute(builder: (_) => MainView());
      case Routes.storeDetailRoute:
        return MaterialPageRoute(builder: (_) => StoredetailView());
      default:
        return unDefindRoute();
    }
  }

  static Route<dynamic> unDefindRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
            appBar: AppBar(
              title: Text("No route Found"),
            ),
            body: Center(
              child: Text("No route Found"),
            )));
  }
}
