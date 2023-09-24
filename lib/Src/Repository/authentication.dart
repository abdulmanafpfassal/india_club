import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:india_club/Helpers/network.dart';
import 'package:india_club/Helpers/utils.dart';
import 'package:india_club/Src/Provider/authentication_provider.dart';
import 'package:india_club/Src/WebService/webService.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationRepo {
  ApiService _service = ApiService();

  Future<Map<String, dynamic>> loginUser() async {
    Map<String, dynamic> responseData = {};
    try {
      Map<String, String> headers = {"Content-Type": "application/json"};

      var body = jsonEncode({
        "jsonrpc": "2.0",
        "params": {
          "db": NetworkUrls.DB,
          "login": getContext.navigatorKey.currentContext!
              .read<AuthenticationProvider>()
              .userName,
          "password": getContext.navigatorKey.currentContext!
              .read<AuthenticationProvider>()
              .password
        }
      });

      final response =
          await _service.postResponse(NetworkUrls.LOGIN, body, headers);
      var cookies = response.headers['set-cookie'];
      log("?????" + response.headers.toString());
      log(">>>>>>>>>" + cookies.toString());
      if (cookies.contains('session_id')) {
        final sessionId = cookies.split(';')[0].split('=')[1];
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString("session", sessionId);
        log("message " + preferences.getString("session").toString());
      }

      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        responseData = responseBody;
      }
    } catch (e) {
      if (kDebugMode) {
        log("message" + e.toString());
      }
    }
    return responseData;
  }

  Future<Map<String, dynamic>> doLogout() async {
    Map<String, dynamic> responseData = {};
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var session_id = preferences.getString("session");

      print("session" + session_id.toString());

      Map<String, String> headers = {
        'Content-Type': 'application/json',
        "X-Openerp-Session-id": "$session_id"
      };

      var body = jsonEncode({
        "jsonrpc": "2.0",
        "params": {
          "db": NetworkUrls.DB,
        }
      });

      final response =
          await _service.postResponse(NetworkUrls.LOGOUT, body, headers);

      log("message" + response.statusCode.toString());
      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        responseData = responseBody;
      }
    } catch (e) {
      log("message" + e.toString());
    }
    return responseData;
  }

  Future<Map<String, dynamic>> getMemberDetails() async {
    Map<String, dynamic> responseData = {};
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var session_id = preferences.getString("session");
      var uid = preferences.getInt("uid");

      print("session" + session_id.toString());

      Map<String, String> headers = {
        'Content-Type': 'application/json',
        "X-Openerp-Session-id": "$session_id"
      };

      final response = await _service.getResponse(
          NetworkUrls.member_details + uid.toString(), headers);

      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        responseData = responseBody;
      }
    } catch (e) {
      log(e.toString());
    }
    return responseData;
  }

}
