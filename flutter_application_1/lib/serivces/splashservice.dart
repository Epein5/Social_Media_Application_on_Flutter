import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_application_1/serivces/authorization/emailpasswordauth.dart';
import 'package:flutter_application_1/serivces/userstatusservice.dart';
import 'package:flutter_application_1/utlis/routes/routes.dart';

class SplashService {
  isLoggedIn(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    CurrentUserStatus userStatus = CurrentUserStatus();

    Timer(const Duration(seconds: 1), () {
      if (user == null) {
        Navigator.pushReplacementNamed(context, RouteName.loginview);
      } else {
        userStatus.checkDocument(context);
      }
    });
  }
}
