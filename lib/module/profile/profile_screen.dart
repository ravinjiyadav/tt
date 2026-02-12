import 'package:book_your_truck/module/paymentHistory/payment_history_screen.dart';
import 'package:book_your_truck/module/profile/edit_profile_screen.dart';
import 'package:book_your_truck/utilities/color_utility.dart';
import 'package:book_your_truck/utilities/image_utility.dart';
import 'package:book_your_truck/utilities/style_utility.dart';
import 'package:book_your_truck/module/profile/trip_history_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../routes/app_routes.dart';
import '../../utilities/shared_preference.dart';
import '../auth/login/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtility.backgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 25.h),

            Container(
              width: 135,
              height: 135,
              child: ClipOval(
                child: cachedNetworkImageCustom(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcStvL8kNVKvJskGpi8do02RNw2bn3sKxTTJ2g&s",
                ),
              ),
            ),

            SizedBox(height: 15.h),

            Text(
              "Ravi JI",
              style: StyleUtility.nunitoBold16colorBlackTextStyle,
            ),

            SizedBox(height: 5.h),
            Text(
              "+91 12345 67890",
              style: StyleUtility.nunitoRegular14color364B63TextStyle,
            ),

            SizedBox(height: 18.h),

            SettingTile(
              title: "View profile",
              icon: ImageUtility.profileFillIcon,
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfileScreen()));
              },
            ),
            SettingTile(
              title: "Support Customer",
              icon: ImageUtility.supportIcon,
              onTap: (){
              },
            ),
            SettingTile(
              title: "Payment history",
              icon: ImageUtility.paymentHistoryIcon,
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentHistoryScreen()));
              },
            ),
            SettingTile(
              title: "Trips history",
              icon: ImageUtility.tripHistoryIcon,
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => TripsHistoryScreen()));
                },

            ),
            SettingTile(
              title: "Logout",
              icon: ImageUtility.logOutIcon,
              isSuffix: false,
              onTap: (){

                Preference().clearSharedPreference();
                AppRoute.loginScreen(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget cachedNetworkImageCustom(
  String imgUrl, {
  String errorImgUrl = '',
  bool fit = false,
  IconData errorIcon = Icons.error,
}) {
  return imgUrl == ''
      ? Image.asset(errorImgUrl, fit: BoxFit.contain)
      : CachedNetworkImage(
          imageUrl: imgUrl,
          placeholder: (context, url) =>
              const Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => errorImgUrl == ''
              ? const Icon(Icons.error, color: Colors.red)
              : Image.asset(errorImgUrl, fit: BoxFit.contain),
          fit: fit ? BoxFit.contain : BoxFit.cover,
        );
}

class SettingTile extends StatelessWidget {
  final String title;
  final String icon;
  final bool isSuffix;
  final VoidCallback onTap;

  const SettingTile({
    super.key,
    required this.title,
    required this.icon,
    this.isSuffix = true, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(15.w),
        child: Row(
          children: [
            Image.asset(icon, width: 22.w),

            SizedBox(width: 12.w),

            Expanded(
              child: Text(
                title,
                style: StyleUtility.nunitoSemiBold15color132235TextStyle,
              ),
            ),

            isSuffix == true
                ? Image.asset(
                    ImageUtility.arrowRightIcon,
                    width: 18.w,
                    fit: BoxFit.contain,
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
