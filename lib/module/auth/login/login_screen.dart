import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import '../../../logger/app_logger.dart';
import '../../../routes/app_routes.dart';
import '../../../utilities/app_notifier.dart';
import '../../../utilities/color_utility.dart';
import '../../../utilities/common.dart';
import '../../../utilities/enums.dart';
import '../../../utilities/image_utility.dart';
import '../../../utilities/style_utility.dart';
import '../../../utilities/text_size_utility.dart';
import '../../../utilities/validation.dart';
import '../../../widgets/buttons/custom_button.dart';
import '../../../widgets/textField/mobile_number_text_field.dart';
import '../../../widgets/textField/simple_text_field.dart';
import 'login_provider.dart';
import 'model/login_request.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int selectIndex = 0;

  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String? countryCode;
  LoginProvider? loginProvider;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    loginProvider = Provider.of<LoginProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFF6A00),
      // resizeToAvoidBottomInset: true,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      /// ORANGE HEADER (fills remaining space)
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: Color(0xFFFF6A00),
                          ),
                          child: Center(
                            child: Image.asset(
                              ImageUtility.truckIcon,
                              width: 197.w,
                            ),
                          ),
                        ),
                      ),

                      /// WHITE CARD (takes only required height)
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: 22.w,
                          vertical: 22.h,
                        ),
                        decoration: BoxDecoration(
                          color: ColorUtility.colorF5F6FA,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(30),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Sign in with",
                              style: StyleUtility.latoRegular18BlackTextStyle,
                            ),

                            SizedBox(height: 21.h),

                            Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectIndex = 0;
                                      });
                                    },
                                    child: Container(
                                      height: TextSizeUtility.buttonHeight,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(
                                          20.r,
                                        ),
                                        border: Border.all(
                                          color: selectIndex == 0
                                              ? ColorUtility.colorEA580C
                                              : ColorUtility.color767C8C,
                                        ),
                                      ),

                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            ImageUtility.maleIcon,
                                            width: 12.w,

                                            color: selectIndex == 0
                                                ? ColorUtility.colorEA580C
                                                : ColorUtility.color767C8C,
                                          ),

                                          SizedBox(width: 7.w),

                                          Text(
                                            "Mobile Number",
                                            style: StyleUtility
                                                .lato15RegularcolorEA580CTextStyle
                                                .copyWith(
                                                  // fontSize:
                                                  // TextSizeUtility.textSize10,
                                                  color: selectIndex == 0
                                                      ? ColorUtility.colorEA580C
                                                      : ColorUtility
                                                            .colorB1B1B1,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 10),

                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectIndex = 1;
                                      });
                                    },
                                    child: Container(
                                      height: TextSizeUtility.buttonHeight,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(
                                          20.r,
                                        ),
                                        border: Border.all(
                                          color: selectIndex == 1
                                              ? ColorUtility.colorEA580C
                                              : ColorUtility.color767C8C,
                                        ),
                                      ),

                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            ImageUtility.maleIcon,
                                            width: 12.w,

                                            color: selectIndex == 1
                                                ? ColorUtility.colorEA580C
                                                : ColorUtility.color767C8C,
                                          ),

                                          SizedBox(width: 7.w),

                                          Text(
                                            "Email ID",
                                            style: StyleUtility
                                                .lato15RegularcolorEA580CTextStyle
                                                .copyWith(
                                                  // fontSize:
                                                  // TextSizeUtility.textSize10,
                                                  color: selectIndex == 1
                                                      ? ColorUtility.colorEA580C
                                                      : ColorUtility
                                                            .colorB1B1B1,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 19.h),

                            selectIndex == 0
                                ? PhoneNumberTextField(
                                    controller: mobileNumberController,
                                    initialCountryCode: 'IN',
                                    onChanged: (value) {
                                      print("Value number => ${value!.number}");
                                      countryCode = value.countryCode;
                                      print(
                                        "country code is from input number =>  ${countryCode}",
                                      );
                                      return null;
                                    },
                                    hintText: "Enter your mobile number",
                                    validators: Validators(
                                      context,
                                    ).validateMobile,
                                  )
                                : SimpleTextField(
                                    controller: emailController,
                                    hintText: "Enter your Email ID",
                                    title: "Email",

                                    validator: Validators(
                                      context,
                                    ).validatorEmail,
                                  ),

                            SizedBox(height: 18.h),

                            CustomButton(
                              buttonText: "Get OTP",
                              onTap: () {
                              //  CommonMethod.hideKeyBoard(context);

                                // if (mobileNumberController.text.length < 6) {
                                //   AppNotifier.showErrorSnackBar(
                                //     message: "Please enter mobile number",
                                //   );
                                //
                                //   return;
                                // }

                                if (_formKey.currentState!.validate()) {



                                  if (mobileNumberController.length < 6) {
                                    AppNotifier.showErrorSnackBar(
                                      message: "Please Enter Mobile Number",
                                    );
                                    return;
                                  }
                                  AppLogger.logD(
                                    "Enter mobile number is ${mobileNumberController.text}",
                                  );
                                  AppLogger.logD(
                                    "Enter mobile number is ${countryCode}",
                                  );

                                  CommonMethod.showLoadingDialog(context);
                                  loginProvider?.logIn(
                                    onSuccess: (response) {
                                      Navigator.pop(context);

                                      AppRoute.verifyOtLoginScreen(
                                        context,
                                        mobileNumberController.text,
                                      );
                                    },

                                    onFailure: (message) {
                                      Navigator.pop(context);
                                      AppNotifier.showErrorSnackBar(
                                        message: message.toString(),
                                      );
                                    },
                                    request: LoginRequest(
                                      phone: mobileNumberController.text,
                                    ),
                                  );
                                }

                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => VerifyOtLoginScreen(),
                                //   ),
                                // );
                              },
                            ),

                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 26.h),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 1,
                                      color: ColorUtility.colorEA580C,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 13.w,
                                    ),
                                    child: Text(
                                      "Don’t have an Account",
                                      style: StyleUtility
                                          .latoRegularBlack13TextStyle,
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 1,
                                      color: ColorUtility.colorEA580C,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            CustomButton(
                              buttonText: "Sign Up",
                              type: ButtonType.border,
                              onTap: () {
                                AppRoute.signupScreen(context);
                              },
                            ),

                            CustomButton(
                              buttonText: "Create Order",
                              type: ButtonType.border,
                              onTap: () {
                                AppRoute.createOrderScreen(context);
                              },
                            ),



                            SizedBox(height: 32.h),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
