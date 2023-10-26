import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:india_club/Helpers/colors.dart';
import 'package:india_club/Helpers/utils.dart';
import 'package:india_club/HomePage/dashboard.dart';
import 'package:india_club/PreLogin/login_page.dart';
import 'package:india_club/Src/Provider/sports_provider.dart';
import 'package:india_club/Src/Repository/authentication.dart';
import 'package:m_toast/m_toast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationProvider with ChangeNotifier {
  AuthenticationRepo _authenticationRepo = AuthenticationRepo();
  ShowMToast _mToast = ShowMToast(getContext.navigatorKey.currentContext!);
  dynamic loginResponse;
  dynamic logoutResponse;
  bool isLoading = false;
  String userName = "";
  String password = "";
  dynamic memberDetails;
  dynamic resetPasswordData;

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
      await preferences.setInt(
          "uid", loginResponse["result"]["uid"]);
      await preferences.setInt(
          "partnerId", loginResponse["result"]["partner_id"]);
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
                    "Access Denied",
                    style:
                        GoogleFonts.poppins(fontSize: 14.sp, color: Colors.red),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "Whoops! Your credentials are invalid",
                    style: GoogleFonts.poppins(fontSize: 12.sp),
                  ),
                  SizedBox(height: 10.h),
                  // Add spacing between the text and other content
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      primary: ColorPellets.orange, // Set the background color to teal
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
        _mToast.errorToast(
            message: "Server Error", alignment: Alignment.bottomCenter);
      });
      isLoading = false;
    } else {
      setIsLoading(false);
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.clear();
      Navigator.of(getContext.navigatorKey.currentContext!).pushAndRemoveUntil(
          MaterialPageRoute(builder: (ctx) => LoginPage()), (route) => false);
    }
  }

  setMemberDetails() async {
    memberDetails =  await _authenticationRepo.getMemberDetails();
    log("message" + memberDetails.toString());
    if(memberDetails != null) {
      getContext.navigatorKey.currentContext!.read<SportsBookingProvider>().setMembershipId(memberDetails["data"][0]["membership_no"].toString());
      getContext.navigatorKey.currentContext!.read<SportsBookingProvider>().setEmail(memberDetails["data"][0]["email"].toString());
      getContext.navigatorKey.currentContext!.read<SportsBookingProvider>().setGender(memberDetails["data"][0]["gender"]);
    }
    notifyListeners();
  }

  doResetPassword(String email) async {
    setIsLoading(true);
    resetPasswordData = await _authenticationRepo.resetPassword(email);
    setIsLoading(false);
    log("message" + resetPasswordData.toString());
    if(resetPasswordData.containsKey("result")){
      Fluttertoast.showToast(
        msg: resetPasswordData["result"]["message"].toString(),
        toastLength: Toast.LENGTH_LONG, // You can change this to Toast.LENGTH_LONG if you want a longer duration
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1, // iOS only
        backgroundColor: Colors.greenAccent,
        textColor: Colors.black,
        fontSize: 12.0,
      );
    }else{
      Fluttertoast.showToast(
        msg: "User Doesn't Exist",
        toastLength: Toast.LENGTH_LONG, // You can change this to Toast.LENGTH_LONG if you want a longer duration
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1, // iOS only
        backgroundColor: Colors.redAccent,
        textColor: Colors.black,
        fontSize: 12.0,
      );    }
    notifyListeners();
  }

}
