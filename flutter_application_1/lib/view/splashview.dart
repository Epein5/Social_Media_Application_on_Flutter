import 'package:flutter/material.dart';
import 'package:flutter_application_1/serivces/splashservice.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    SplashService splashService = SplashService();
    splashService.isLoggedIn(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset('assets/splash.png'),
              Image.asset(
                'assets/logo.png',
                height: 150,
                width: 150,
              )
            ],
          ),
        ],
      ),
    );
  }
}
