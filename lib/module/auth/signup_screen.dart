// import 'package:book_your_truck/module/auth/verify_otp_screen.dart';
// import 'package:book_your_truck/utilities/color_utility.dart';
// import 'package:book_your_truck/utilities/style_utility.dart';
// import 'package:book_your_truck/utilities/text_size_utility.dart';
// import 'package:book_your_truck/widgets/common_app_bar.dart';
// import 'package:book_your_truck/widgets/textField/mobile_number_text_field.dart';
// import 'package:book_your_truck/widgets/textField/simple_text_field.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../utilities/image_utility.dart';
// import '../../widgets/buttons/custom_button.dart';
//
// class SignupScreen extends StatefulWidget {
//   const SignupScreen({super.key});
//
//   @override
//   State<SignupScreen> createState() => _SignupScreenState();
// }
//
// class _SignupScreenState extends State<SignupScreen> {
//   TextEditingController fNameController = TextEditingController();
//   TextEditingController lNameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController mobileController = TextEditingController();
//   TextEditingController gstController = TextEditingController();
//
//   String? countryCode;
//
//   int? gender;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//      backgroundColor: ColorUtility.colorF5F6FA,
//
//       appBar: commonAppBar(title: "Sign Up"),
//
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
//             child: Column(
//               children: [
//                 SimpleTextField(
//                   preffixImage: ImageUtility.userIcon,
//                   title: "First Name",
//                   controller: fNameController,
//                   hintText: "Enter first name",
//                 ),
//
//                 SizedBox(height: 16.h),
//
//                 SimpleTextField(
//                   preffixImage: ImageUtility.userIcon,
//                   title: "Last Name",
//                   controller: lNameController,
//                   hintText: "Enter last name",
//                 ),
//
//                 SizedBox(height: 16.h),
//
//                 SimpleTextField(
//                   preffixImage: ImageUtility.emailIcon,
//                   title: "Email",
//                   controller: emailController,
//                   hintText: "Enter email",
//                 ),
//
//                 SizedBox(height: 16.h),
//
//                 SimpleTextField(
//                   preffixImage: ImageUtility.gstIcon,
//                   title: "GST Number",
//                   controller: emailController,
//                   hintText: "Enter GST number",
//                 ),
//
//                 SizedBox(height: 16.h),
//
//                 PhoneNumberTextField(
//                   controller: mobileController,
//                   initialCountryCode: 'IN',
//                   onChanged: (value) {
//                     print("Value number${value!.completeNumber}");
//                     countryCode = value.countryCode;
//                     print("country code is from input number ${countryCode}");
//                     return null;
//                   },
//                   hintText: "Enter your mobile number",
//                 ),
//                 SizedBox(height: 16.h),
//
//                 Row(
//                   children: [
//                     Expanded(
//                       child: InkWell(
//                         onTap: () {
//                           setState(() {
//                             gender = 2;
//                           });
//                         },
//                         child: Container(
//                           height: TextSizeUtility.buttonHeight,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(50.r),
//                             color: gender == 2
//                                 ? ColorUtility.colorEA580C
//                                 : Colors.white,
//                           ),
//
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Image.asset(
//                                 ImageUtility.femaleIcon,
//                                 width: 12.w,
//                                 color: gender == 2
//                                     ? Colors.white
//                                     : ColorUtility.color767C8C,
//                               ),
//
//                               SizedBox(width: 7.w),
//
//                               Text(
//                                 "Female",
//                                 style: StyleUtility.buttonTextStyle.copyWith(
//                                   color: gender == 2
//                                       ? Colors.white
//                                       : ColorUtility.color767C8C,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//
//                     SizedBox(width: 20.w),
//
//                     Expanded(
//                       child: InkWell(
//                         onTap: () {
//                           setState(() {
//                             gender = 1;
//                           });
//                         },
//                         child: Container(
//                           height: TextSizeUtility.buttonHeight,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20.r),
//                             color: gender == 1
//                                 ? ColorUtility.colorEA580C
//                                 : Colors.white,
//                           ),
//
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Image.asset(
//                                 ImageUtility.maleIcon,
//                                 width: 12.w,
//
//                                 color: gender == 1
//                                     ? Colors.white
//                                     : ColorUtility.color767C8C,
//                               ),
//
//                               SizedBox(width: 7.w),
//
//                               Text(
//                                 "Male",
//                                 style: StyleUtility.buttonTextStyle.copyWith(
//                                   color: gender == 1
//                                       ? Colors.white
//                                       : ColorUtility.color767C8C,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//
//                 SizedBox(height: 77.h),
//                 CustomButton(
//                   buttonText: "Sign up",
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => VerifyOtpScreen(),
//                       ),
//                     );
//                   },
//                 ),
//
//                 SizedBox(height: 32.h),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
