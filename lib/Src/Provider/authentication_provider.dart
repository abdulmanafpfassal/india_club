import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:india_club/Helpers/utils.dart';
import 'package:india_club/HomePage/dashboard.dart';
import 'package:india_club/Src/Repository/authentication.dart';
import 'package:m_toast/m_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationProvider with ChangeNotifier {
  AuthenticationRepo _authenticationRepo = AuthenticationRepo();
  ShowMToast _mToast = ShowMToast();
  dynamic loginResponse;
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
      if(kDebugMode){
        log(loginResponse.toString());
      }
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString("name", loginResponse["result"]["name"].toString());
      preferences.setString("mem_id", loginResponse["result"]["membership_no"].toString());
      preferences.setString("email", loginResponse["result"]["email"].toString());
      Navigator.of(getContext.navigatorKey.currentContext!).pushAndRemoveUntil(
          MaterialPageRoute(builder: (ctx) => Dashboard()), (route) => false);
    } else {
      setIsLoading(false);
      _mToast.errorToast(getContext.navigatorKey.currentContext!,
          message: "Invalid Credentials", alignment: Alignment.bottomCenter);
    }
  }
}
