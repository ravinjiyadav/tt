import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../../../../routes/app_routes.dart';
import '../../../../utilities/app_notifier.dart';
import '../../../../utilities/color_utility.dart';
import '../../../../utilities/common.dart';
import '../../../../utilities/image_utility.dart';
import '../../../../utilities/style_utility.dart';
import '../../../../utilities/text_size_utility.dart';
import '../../../../utilities/validation.dart';
import '../../../../widgets/buttons/custom_button.dart';
import '../../../../widgets/common_app_bar.dart';
import '../../../../widgets/textField/mobile_number_text_field.dart';
import '../../../../widgets/textField/simple_text_field.dart';
import '../model/signup_request.dart';
import '../provider/signup_provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController gstController = TextEditingController();
  TextEditingController transporterNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  String? countryCode;

  int gender = 1;

  SignUpProvider? signUpProvider;

  final _formKey = GlobalKey<FormState>();


  @override
  void initState() {
    super.initState();
    signUpProvider = Provider.of<SignUpProvider>(context, listen: false);

    gstController.text = kDebugMode ? "09AAACH7409R1ZZ" : "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtility.colorF5F6FA,

      appBar: commonAppBar(title: "Sign Up"),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 15.h),

                  SimpleTextField(
                    preffixImage: ImageUtility.userIcon,
                    title: "Your Name",
                    controller: fNameController,
                    hintText: "Enter your name",
                     validator: Validators(context).validatorFirstName,

                  ),

                  SizedBox(height: 16.h),

                  SimpleTextField(
                    preffixImage: ImageUtility.userIcon,
                    title: "Last Name",
                    controller: lNameController,
                    hintText: "Enter last name",
                      validator: Validators(context).validatorLastName
                  ),
                  SizedBox(height: 16.h),

                  SimpleTextField(
                    preffixImage: ImageUtility.emailIcon,
                    title: "Email",
                    controller: emailController,
                    hintText: "Enter email",
                     validator: Validators(context).validatorEmail,

                  ),

                  SizedBox(height: 16.h),

                  SimpleTextField(
                    preffixImage: ImageUtility.gstIcon,
                    title: "GST Number",
                    controller: gstController,
                    textInputType: TextInputType.text,
                    hintText: "Enter GST number",
                    validator: Validators(context).validateGSt,
                  ),

                  SizedBox(height: 16.h),

                

                 


                  PhoneNumberTextField(
                    controller: mobileController,
                    initialCountryCode: 'IN',
                    onChanged: (value) {
                      print("Value number${value!.completeNumber}");
                      countryCode = value.countryCode;
                      print("country code is from input number ${countryCode}");
                      return null;
                    },
                    hintText: "Enter your mobile number",
                    validators: Validators(context).validateMobile,

                  ),
                  SizedBox(height: 16.h),

                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              gender = 2;
                            });
                          },
                          child: Container(
                            height: TextSizeUtility.buttonHeight,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.r),
                              color: gender == 2
                                  ? ColorUtility.colorEA580C
                                  : Colors.white,
                            ),

                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  ImageUtility.femaleIcon,
                                  width: 12.w,
                                  color: gender == 2
                                      ? Colors.white
                                      : ColorUtility.color767C8C,
                                ),

                                SizedBox(width: 7.w),

                                Text(
                                  "Female",
                                  style: StyleUtility.buttonTextStyle.copyWith(
                                    color: gender == 2
                                        ? Colors.white
                                        : ColorUtility.color767C8C,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: 20.w),

                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              gender = 1;
                            });
                          },
                          child: Container(
                            height: TextSizeUtility.buttonHeight,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.r),
                              color: gender == 1
                                  ? ColorUtility.colorEA580C
                                  : Colors.white,
                            ),

                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  ImageUtility.maleIcon,
                                  width: 12.w,

                                  color: gender == 1
                                      ? Colors.white
                                      : ColorUtility.color767C8C,
                                ),

                                SizedBox(width: 7.w),

                                Text(
                                  "Male",
                                  style: StyleUtility.buttonTextStyle.copyWith(
                                    color: gender == 1
                                        ? Colors.white
                                        : ColorUtility.color767C8C,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 77.h),
                  CustomButton(
                    buttonText: "Sign up",
                    onTap: () {



                      if(_formKey.currentState!.validate()){

                        if(mobileController.length < 6){

                          AppNotifier.showErrorSnackBar(
                            message: "Please Enter Mobile Number",
                          );
                          return;
    }
                          signUpProvider?.request = SignupRequest(
                            fName: fNameController.text.trim(),
                            lName: lNameController.text.trim(),
                            email: emailController.text.trim(),
                            phone: mobileController.text,
                            gst_number: gstController.text.trim(),
                           // gender: addressController.text.trim(),
                            gender: gender == 1 ? "male" : "female",
                          );


                        CommonMethod.showLoadingDialog(context);
                          signUpProvider?.signup(
                            onSuccess: (v) {
                              Navigator.pop(context);
                              AppRoute.loginScreen(context);
                              AppNotifier.showSuccessSnackBar(message: v);


                            },
                            onFailure: (v) {
                              Navigator.pop(context);
                              AppNotifier.showErrorSnackBar(message: v);
                            },
                            request: signUpProvider!.request,
                          );

                          


                      }


                    },
                  ),

                  SizedBox(height: 32.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
