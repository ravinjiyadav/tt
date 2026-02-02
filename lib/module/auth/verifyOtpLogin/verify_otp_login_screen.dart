import 'package:book_your_truck/module/auth/verifyOtpLogin/verify_otp_login_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../../../routes/app_routes.dart';
import '../../../utilities/app_notifier.dart';
import '../../../utilities/color_utility.dart';
import '../../../utilities/common.dart';
import '../../../utilities/style_utility.dart';
import '../../../widgets/buttons/custom_button.dart';
import '../../../widgets/common_app_bar.dart';
import '../../../widgets/textField/custom_otp_text_field.dart';

class VerifyOtLoginScreen extends StatefulWidget {
  final String phone;

  const VerifyOtLoginScreen({super.key, required this.phone});

  @override
  State<VerifyOtLoginScreen> createState() => _VerifyOtLoginScreenState();
}

class _VerifyOtLoginScreenState extends State<VerifyOtLoginScreen> {
  TextEditingController otpController = TextEditingController();

  late VerifyOtpLoginProvider verifyOtpLoginProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    verifyOtpLoginProvider = Provider.of<VerifyOtpLoginProvider>(
      context,
      listen: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtility.backgroundColor,
      appBar: commonAppBar(title: "Verify OTP"),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              SizedBox(height: 40.h),

              Text(
                "Otp Verification",
                style: StyleUtility.manropeSemiBold18Color0E0E0E,
              ),
              SizedBox(height: 16.h),
              Text(
                "We just sent you an SMS with 4-digit code. looks like very soon you will be logged in!",
                style: StyleUtility.manropeMedium16Color848B9D,
              ),

              SizedBox(height: 28.h),
              Container(
                alignment: Alignment.center,
                child: CustomOtpField(controller: otpController),
              ),

              // SizedBox(height: 28.h),
              //
              // Container(
              //   alignment: Alignment.center,
              //   child: Text(
              //     "I haven’t received a code (0:03)",
              //     style: StyleUtility.manropeMedium16Color848B9D.copyWith(
              //       color: Colors.black.withValues(alpha: 0.8),
              //     ),
              //   ),
              // ),

              SizedBox(height: 114.h),

              CustomButton(
                buttonText: "Verify",
                onTap: () {
                  if (otpController.length < 4) {
                    AppNotifier.showErrorSnackBar(message: "Please enter OTP");
                    return;
                  }

                  CommonMethod.showLoadingDialog(context);
                  verifyOtpLoginProvider.verifyOtp(
                    onSuccess: (message) {
                      Navigator.pop(context);
                      AppRoute.bottomBarScreen(context);
                      AppNotifier.showSuccessSnackBar(message: message);

                    },

                    onFailure: (message) {
                      Navigator.pop(context);
                      AppNotifier.showErrorSnackBar(
                        message: message.toString(),
                      );
                    },
                    otp: otpController.text,
                    phone: widget.phone,
                  );
                },
              ),

              SizedBox(height: 35.h),
            ],
          ),
        ),
      ),
    );
  }
}
