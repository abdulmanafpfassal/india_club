import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:india_club/Helpers/utils.dart';
import 'package:india_club/HomePage/dashboard.dart';
import 'package:india_club/PreLogin/login_page.dart';
import 'package:india_club/Src/Repository/authentication.dart';
import 'package:m_toast/m_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationProvider with ChangeNotifier {
  AuthenticationRepo _authenticationRepo = AuthenticationRepo();
  ShowMToast _mToast = ShowMToast();
  dynamic loginResponse;
  dynamic logoutResponse;
  bool isLoading = false;
  String userName = "";
  String password = "";

  setUserAndPassword(String text1, String text2) {
    userName = text1;
    password = text2;
  }

  setIsLoading(bool flag) {
    isLoading = flag;
    notifyListeners();
  }

  doLogin() async {
    setIsLoading(true);
    loginResponse = await _authenticationRepo.loginUser();
    if (loginResponse.containsKey("result")) {
      setIsLoading(false);
      if (kDebugMode) {
        log(loginResponse.toString());
      }
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setString("name", loginResponse["result"]["name"].toString());
      await preferences.setString("uid", loginResponse["result"]["uid"].toString());
      await preferences.setString(
          "mem_id", loginResponse["result"]["membership_no"].toString());
      await preferences.setString(
          "whatsapp", loginResponse["result"]["whatsapp_no"].toString());
      await preferences.setString(
          "address", loginResponse["result"]["address"].toString());
      await preferences.setString(
          "email", loginResponse["result"]["email"].toString());
      await preferences.setString(
          "dep", json.encode(loginResponse["result"]["dependent_detailes"]));
      Navigator.of(getContext.navigatorKey.currentContext!).pushAndRemoveUntil(
          MaterialPageRoute(builder: (ctx) => Dashboard()), (route) => false);
    } else {
      setIsLoading(false);
      showDialog(
        context: getContext.navigatorKey.currentContext!,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
                vertical: 20.h, // Adjust the vertical padding as needed
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Failed",
                    style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        color: Colors.red
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "Invalid Credentials",
                    style: GoogleFonts.poppins(fontSize: 12.sp),
                  ),
                  SizedBox(height: 10.h),
                  // Add spacing between the text and other content
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      primary: Colors.teal, // Set the background color to teal
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog box
                    },
                    child: Text('Try Again'),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }

    doLogout() async {
      setIsLoading(true);
      logoutResponse = await _authenticationRepo.doLogout();
      if (logoutResponse.containsKey("error")) {
        Future.delayed(Duration(seconds: 1), () {
          _mToast.errorToast(getContext.navigatorKey.currentContext!,
              message: "Server Error", alignment: Alignment.bottomCenter);
        });
        isLoading = false;
      } else {
        setIsLoading(false);
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.clear();
        Navigator.of(getContext.navigatorKey.currentContext!)
            .pushAndRemoveUntil(
            MaterialPageRoute(builder: (ctx) => LoginPage()), (route) => false);
      }
    }

}
