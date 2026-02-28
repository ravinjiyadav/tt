import 'package:book_your_truck/module/bottomabar/dashboard/select_location_screen.dart';
import 'package:book_your_truck/module/bottomabar/dashboard/track/track_truck_screen.dart';
import 'package:book_your_truck/utilities/color_utility.dart';
import 'package:book_your_truck/utilities/image_utility.dart';
import 'package:book_your_truck/utilities/style_utility.dart';
import 'package:book_your_truck/widgets/buttons/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../routes/app_routes.dart';
import '../notification/notification_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _Header(),
            SizedBox(height: 29.h),
            _LocationInputCard(),
            SizedBox(height: 28.h),
            _BannerCard(),
            SizedBox(height: 21.h),
            _CheckPriceCard(),
            SizedBox(height: 21.h),
            Text(
              "Active Trucks",
              style: StyleUtility.manropeMedium14colorBlack,
            ),
            SizedBox(height: 13.h),
            _ActiveTruckCard(),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Logo", style: StyleUtility.manropeSemiBold12ColorBlack),
              SizedBox(height: 4.h),
              Text(
                "👋 Hi Ravi !",
                style: StyleUtility.manropeSemiBold12Color474C59,
              ),
            ],
          ),
        ),
        InkWell(
          onTap: (){

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NotificationScreen()),
            );


          },
          child: Stack(
            children: [
              Icon(
                Icons.notifications_none,
                size: 28,
                color: ColorUtility.color1F2937,
              ),
              Positioned(
                right: 2,
                top: 2,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _LocationInputCard extends StatelessWidget {
  const _LocationInputCard();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: ColorUtility.color8D98AF),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    _dot(ColorUtility.colorEA580C),
                    Container(
                      width: 2,
                      height: 32.h,
                      color: Colors.grey.shade300,
                    ),
                    Image.asset(ImageUtility.unLoadingIconIcon, width: 18.w),
                  ],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Loading Location?",
                        style: StyleUtility.manropeMedium14Color767C8C,
                      ),
                      Padding(
                        padding: EdgeInsetsGeometry.symmetric(vertical: 8.h),
                        child: Divider(color: ColorUtility.colorF0F2F9),
                      ),
                      Text(
                        "Unloading Location?",
                        style: StyleUtility.manropeMedium14Color767C8C,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        GestureDetector(
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => SelectLocationScreen()),
            // );

            AppRoute.createOrderScreen(context);


          },
          child: CircleAvatar(
            radius: 24,
            backgroundColor: Colors.grey.shade200,
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }

  Widget _dot(Color color) {
    return Container(
      width: 12.w,
      height: 12.w,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class _BannerCard extends StatelessWidget {
  const _BannerCard();

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      ImageUtility.dummyTruckCardImage,
      width: double.infinity,
      fit: BoxFit.contain,
    );

    //   Container(
    //   padding: const EdgeInsets.all(20),
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(16),
    //     gradient: const LinearGradient(
    //       colors: [Colors.black, Color(0xFF1F1F3D)],
    //     ),
    //   ),
    //   child: Row(
    //     children: [
    //       const Expanded(
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Text(
    //               "Ship Anywhere, Anytime!",
    //               style: TextStyle(
    //                 color: Colors.white,
    //                 fontSize: 18,
    //                 fontWeight: FontWeight.w600,
    //               ),
    //             ),
    //             SizedBox(height: 6),
    //             Text(
    //               "Fast, Safe, and Affordable Truck\nBooking at Your Fingertips",
    //               style: TextStyle(color: Colors.white70),
    //             ),
    //             SizedBox(height: 12),
    //             _BookNowButton(),
    //           ],
    //         ),
    //       ),
    //       const SizedBox(width: 10),
    //       const Icon(Icons.local_shipping, color: Colors.white, size: 48),
    //     ],
    //   ),
    // );
  }
}

class _BookNowButton extends StatelessWidget {
  const _BookNowButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.deepOrange,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Text("Book Now", style: TextStyle(color: Colors.white)),
    );
  }
}

class _CheckPriceCard extends StatelessWidget {
  const _CheckPriceCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: ColorUtility.cardBorderColor2),
      ),
      child: Row(
        children: [
          Image.asset(ImageUtility.truckCheckPriceImage, width: 32.w),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Just Checking Price?",
                  style: StyleUtility.manropeMedium14colorBlack,
                ),
                SizedBox(height: 12.h),
                Text(
                  "Get Future Trips Now",
                  style: StyleUtility.manropeMedium10Color6E6E6E,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(6.sp),
            decoration: BoxDecoration(
              border: Border.all(color: ColorUtility.colorEA580C),
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16.sp,
              color: ColorUtility.colorEA580C,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActiveTruckCard extends StatelessWidget {
  const _ActiveTruckCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: ColorUtility.cardBorderColor2),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundImage: NetworkImage(
                  "https://i.pravatar.cc/150?img=8",
                ),
                radius: 22,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sanjay Singh",
                      style: StyleUtility.manropeBold14Color1A2530,
                    ),
                    SizedBox(height: 4),
                    Text(
                      "No, 346GHM - Color, White",
                      style: StyleUtility.manropeMedium14Color8D98AF,
                    ),
                  ],
                ),
              ),
              _icon(Icons.chat_bubble_outline),
              const SizedBox(width: 8),
              _icon(Icons.call),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Column(
                children: [
                  _dot(Colors.green),
                  Container(width: 2, height: 30, color: Colors.grey.shade300),
                  _dot(Colors.orange),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Uploading",
                      style: StyleUtility.manropeMedium14colorBlack,
                    ),
                    Padding(
                      padding: EdgeInsetsGeometry.symmetric(vertical: 2.h),
                      child: Divider(color: ColorUtility.colorF0F2F9),
                    ),
                    Text(
                      "Uploading",
                      style: StyleUtility.manropeMedium14colorBlack,
                    ),
                  ],
                ),
              ),

              SizedBox(width: 14.w),
              CircleAvatar(
                backgroundColor: ColorUtility.colorF5F6FA,
                child: Icon(Icons.keyboard_arrow_down),
              ),
            ],
          ),
          const SizedBox(height: 20),
          CustomButton(buttonText: "Track Truck", onTap: () {


            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => LiveTrackScreen()),
            // );

          }),
        ],
      ),
    );
  }

  static Widget _icon(IconData icon) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFFF7F8FA),
      ),
      child: Padding(
        padding: EdgeInsetsGeometry.all(9.w),
        child: Icon(icon, color: Colors.deepOrange, size: 18.sp),
      ),
    );
  }

  static Widget _dot(Color color) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
