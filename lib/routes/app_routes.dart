import 'package:easy_coupon/pages/login_pages/pw_email_reset_page.dart';
import 'package:easy_coupon/pages/login_pages/register.dart';
import 'package:easy_coupon/pages/pages.dart';
import 'package:easy_coupon/pages/student_pages/profile/profile_screen.dart';
import 'package:easy_coupon/pages/student_pages/profile/profile_update_screen.dart';
import 'package:easy_coupon/pages/student_pages/profile/aboutUs.dart';
import 'package:flutter/material.dart';
import 'package:easy_coupon/routes/route_names.dart';
import 'package:easy_coupon/pages/student_pages/student_report.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RouteNames.introductionAnimation:
        return MaterialPageRoute(
            builder: (_) => const IntroductionAnimationScreen());

      case RouteNames.login:
        return MaterialPageRoute(builder: (_) => LoginPage());

      case RouteNames.resetPWEmail:
        return MaterialPageRoute(builder: (_) => PasswordEmailResetPage());

      case RouteNames.home:
        return MaterialPageRoute(builder: (_) => StudentHome());

      case RouteNames.report:
        return MaterialPageRoute(builder: (_) => Student_report());

      case RouteNames.qr:
        return MaterialPageRoute(builder: (_) => QrPage());

      case RouteNames.profile:
        return MaterialPageRoute(builder: (_) => ProfileScreen());

      case RouteNames.register:
        return MaterialPageRoute(builder: (_) => RegisterScreen());

      case RouteNames.updtprofile:
        return MaterialPageRoute(builder: (_) => UpdateProfileScreen());

      case RouteNames.abtus:
        return MaterialPageRoute(builder: (_) => AboutUs());

      case RouteNames.confirm:
        return MaterialPageRoute(
            builder: (_) => ConfirmationPage(
                  val: 3,
                  role: 'canteena',
                  canteenUserId: '',
                  scannedTime: DateTime.now(),
                ));

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
