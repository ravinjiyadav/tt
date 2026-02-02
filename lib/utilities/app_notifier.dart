import 'package:flutter/material.dart';

import 'color_utility.dart';


final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
GlobalKey<ScaffoldMessengerState>();


class AppNotifier {
  /// Show a Success Snack bar
  static void showSuccessSnackBar({required String message}) {
    _showSnackBar(message, Colors.green, Colors.white);
  }

  /// Show an Error Snack bar
  static void showErrorSnackBar({required String message}) {
    _showSnackBar(message, Colors.red, Colors.white);
  }

  static void showInfoSnackBar({required String message}) {
    _showSnackBar(message, Colors.yellow, Colors.black);
  }

  static bool _isSessionExpired = false; // Flag to track session expiration

  static void _showSnackBar(String message, Color bgColor, Color textColor) {
    if (_isSessionExpired) return; // Prevent multiple messages

    _isSessionExpired = true; // Set flag to true

    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: textColor, fontSize: 16),
      ),
      backgroundColor: bgColor,

      duration: Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
      // Makes the SnackBar float above other widgets
      margin: EdgeInsets.only(
        bottom: 30.0, // Margin from the bottom
        left: 20.0, // Margin from the left
        right: 20.0, // Margin from the right
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Optional: Rounded corners
      ),
    );


    scaffoldMessengerKey.currentState
      ?..hideCurrentSnackBar()
      ..showSnackBar(snackBar);

    // ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();
    // ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);

    Future.delayed(Duration(seconds: 3), () {
      _isSessionExpired = false;
    });
  }

}
