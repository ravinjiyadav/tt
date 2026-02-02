
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

import '../../utilities/color_utility.dart' show ColorUtility;
import '../../utilities/style_utility.dart';

class CustomOtpField extends StatelessWidget {
  final TextEditingController controller;
  final int? length;
  CustomOtpField({
    super.key,
    required this.controller,
    this.length,
  });

  final defaultPinTheme = PinTheme(
    width: 57.w,
    height: 57.w,
    textStyle: StyleUtility.inputTextStyle,
    margin: EdgeInsets.only(right: 8.w),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8.r),
      border: Border.all(color: ColorUtility.textFieldBorderColor, width: 1.w),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Pinput(
      controller: controller,
      length: length ?? 6,
      animationDuration: const Duration(seconds: 1),
      defaultPinTheme: defaultPinTheme,
      keyboardType: TextInputType.number,
      onSubmitted: (String pin) {
        // controller.emailOTPController.text = pin;
        controller.text = pin;
      },
      onCompleted: (pin) {
        // AppLogger.logD('onCompleted: $pin');
      },
      onChanged: (value) {
        // AppLogger.logD('onChanged: $value');
      },
      focusedPinTheme: defaultPinTheme.copyDecorationWith(
        border: Border.all(color: ColorUtility.textFieldBorderColor, width: 1.w),
      ),
      submittedPinTheme: defaultPinTheme.copyDecorationWith(
        border: Border.all(color: ColorUtility.textFieldBorderColor, width: 1.w),
      ),
      disabledPinTheme:
      defaultPinTheme.copyDecorationWith(color: ColorUtility.color1B9D16),
      followingPinTheme: defaultPinTheme.copyDecorationWith(),
      errorPinTheme: defaultPinTheme.copyBorderWith(
        border: Border.all(color: Colors.redAccent),
      ),
      pinputAutovalidateMode: PinputAutovalidateMode.disabled,
    );
  }
}
