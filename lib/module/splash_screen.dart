import 'dart:async';
import 'package:flutter/material.dart';
import '../routes/app_routes.dart';
import '../utilities/image_utility.dart';
import '../utilities/shared_preference.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToLogin();
  }

  Future<void> _navigateToLogin() async {
    await Preference().instance();
    Timer(const Duration(seconds: 3), () {
      if (Preference.getUserLogin()) {
        AppRoute.bottomBarScreen(context);
        return;
      }
      AppRoute.loginScreen(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Image.asset(ImageUtility.splashBgImage, fit: BoxFit.cover),
      ),
    );
  }
}
