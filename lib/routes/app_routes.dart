import 'package:easy_coupon/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:easy_coupon/routes/route_names.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RouteNames.introductionAnimation:
        return MaterialPageRoute(
            builder: (_) => const IntroductionAnimationScreen());

      case RouteNames.login:
        return MaterialPageRoute(
            builder: (_) => const SignInThree());

      case RouteNames.pw_reset:
        return MaterialPageRoute(
            builder: (_) => const PwReset());

      case RouteNames.home:
        return MaterialPageRoute(
            builder: (_) =>   Student_home());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
