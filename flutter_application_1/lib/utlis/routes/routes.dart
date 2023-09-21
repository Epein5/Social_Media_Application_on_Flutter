import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/editprofileview.dart';
import 'package:flutter_application_1/view/homeview.dart';
import 'package:flutter_application_1/view/setprofileview.dart';
import 'package:flutter_application_1/view/loginview.dart';
import 'package:flutter_application_1/view/signupview.dart';
import 'package:flutter_application_1/view/splashview.dart';

class RouteName {
  static const String splashview = "SplashView";
  static const String loginview = "LoginView";
  static const String signupview = "SignupView";
  static const String setuprofileview = "SetupProfileView";
  static const String homeview = "HomeVIew";
  static const String editprofileview = "EditProfileView";
}

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.splashview:
        return MaterialPageRoute(builder: (context) => SplashView());
      case RouteName.loginview:
        return MaterialPageRoute(builder: (context) => LoginView());
      case RouteName.signupview:
        return MaterialPageRoute(builder: (context) => SIgnupView());
      case RouteName.setuprofileview:
        return MaterialPageRoute(builder: (context) => SetProfileView());
      case RouteName.homeview:
        return MaterialPageRoute(builder: (context) => HomeView());
      case RouteName.editprofileview:
        return MaterialPageRoute(builder: (context) => EditProfileView());
      default:
        return MaterialPageRoute(builder: (context) {
          return const Scaffold(
            body: Center(
              child: Text("No Page ROutes Defined"),
            ),
          );
        });
    }
  }
}
