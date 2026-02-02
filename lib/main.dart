import 'package:book_your_truck/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'module/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,

          title: 'First Method',
          // You can use the library anywhere in the app even in theme
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,

            brightness: Brightness.light,

            primarySwatch: Colors.blue,

            // textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
          ),

          onGenerateRoute: AppRoute.generateRoute,

        //  home: const SplashScreen(),
          home: child,
        );
      },
      // child:  SignupScreen(),
      // child:  LoginScreen(),
      //  child: VerifyOtpScreen(),
      //  child:  EditProfileScreen(),
      // child:  PaymentHistoryScreen(),
      //child:  TripsHistoryScreen(),
      //  child:  HelpScreen(),
      // child:  ProfileScreen(),
      //  child:  BottomNavigationBarScreen(),


      child: SplashScreen(),

      //   child:  BookingDetailsScreen(),
    );
  }
}
