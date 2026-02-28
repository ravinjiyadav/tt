import 'package:book_your_truck/module/bottomabar/bottombar.dart';
import 'package:book_your_truck/module/bottomabar/order_bids/bids_screen.dart';
import 'package:book_your_truck/module/bottomabar/order_bids/bids_vm.dart';
import 'package:book_your_truck/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../module/auth/login/login_provider.dart';
import '../module/auth/login/login_screen.dart';
import '../module/auth/signup/provider/signup_provider.dart';
import '../module/auth/signup/screen/signup_screen.dart';
import '../module/auth/verifyOtpLogin/verify_otp_login_provider.dart';
import '../module/auth/verifyOtpLogin/verify_otp_login_screen.dart';
import '../module/bottomabar/create_order/create_order_screen.dart';
import '../module/bottomabar/create_order/create_order_vm.dart';
import '../module/bottomabar/order_request/order_request_list_screen.dart';
import '../module/bottomabar/order_request/order_request_list_vm.dart';
import '../module/splash_screen.dart';

class AppRoute {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.loginScreen:
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (_) => LoginProvider(),
            child: LoginScreen(),
          ),
        );

      case RouteName.signupScreen:
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (_) => SignUpProvider(),
            child: SignupScreen(),
          ),
        );

      case RouteName.verifyOtLoginScreen:
        var arg = settings.arguments as Map;

        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (_) => VerifyOtpLoginProvider(),
            child: VerifyOtLoginScreen(phone: arg["phone"]),
          ),
        );

      case RouteName.bottomNavigationBarScreen:
        return MaterialPageRoute(
          builder: (context) => BottomNavigationBarScreen(),
        );

      case RouteName.createOrderScreen:
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (_) => CreateOrderVm(),
            child: CreateOrderScreen(),
          ),
        );

      case RouteName.loadListScreen:
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (_) => OrderRequestListVm(),
            child: LoadListScreen(),
          ),
        );

      case RouteName.bidsScreen:
        var arg = settings.arguments as Map;
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (_) => BidsVm(),
            child: BidsScreen(id: arg["id"]),
          ),
        );

      // case RouteName.editProfileScreen:
      //   return MaterialPageRoute(
      //     builder: (context) => ChangeNotifierProvider(
      //       create: (_) => EditProfileProvider(),
      //       child: EditProfileScreen(),
      //     ),
      //   );

      default:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
    }
  }

  /// Define Navigation

  static Future<void> loginScreen(BuildContext context) async {
    Navigator.pushNamedAndRemoveUntil(
      context,
      RouteName.loginScreen,
      (route) => false,
    );
  }

  static Future<void> signupScreen(BuildContext context) async {
    Navigator.pushNamed(context, RouteName.signupScreen);
  }

  static Future<void> verifyOtLoginScreen(
    BuildContext context,
    String phone,
  ) async {
    Navigator.pushNamed(
      context,
      RouteName.verifyOtLoginScreen,
      arguments: {"phone": phone},
    );
  }

  static Future<void> bottomBarScreen(BuildContext context) async {
    Navigator.pushNamedAndRemoveUntil(
      context,
      RouteName.bottomNavigationBarScreen,
      (route) => false,
    );
  }

  static Future<T?> editProfileScreen<T>(BuildContext context) async {
    return Navigator.pushNamed<T>(context, RouteName.editProfileScreen);
  }

  static Future<void> createOrderScreen(BuildContext context) async {
    Navigator.pushNamed(context, RouteName.createOrderScreen);
  }

  static Future<void> loadListScreen(BuildContext context) async {
    Navigator.pushNamed(context, RouteName.loadListScreen);
  }

  static Future<void> bidsScreen(BuildContext context, int id) async {
    Navigator.pushNamed(context, RouteName.bidsScreen, arguments: {"id": id});
  }

  //
}
