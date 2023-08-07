
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:india_club/Helpers/utils.dart';
import 'package:india_club/PreLogin/login_page.dart';
import 'package:india_club/Src/Provider/authentication_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AuthenticationProvider())
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(360, 640),
        splitScreenMode: true,
        minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          navigatorKey: getContext.navigatorKey,
          debugShowCheckedModeBanner: false,
          home: LoginPage(),
        );
      }
    );
  }
}
