import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:india_club/Helpers/network.dart';
import 'package:india_club/Helpers/utils.dart';
import 'package:india_club/Src/Provider/authentication_provider.dart';
import 'package:india_club/Src/WebService/webService.dart';
import 'package:provider/provider.dart';

class AuthenticationRepo {
  ApiService _service = ApiService();

  Future<Map<String, dynamic>> loginUser() async {
    Map<String, dynamic> responseData = {};
    try{
      Map<String, String> headers = {
        "Content-Type": "application/json"
      };

      var body = jsonEncode({
        "jsonrpc": "2.0",
        "params": {
          "db": "indiaclub1",
          "login": getContext.navigatorKey.currentContext!.read<AuthenticationProvider>().userName,
          "password": getContext.navigatorKey.currentContext!.read<AuthenticationProvider>().password
        }
      });

      final response = await _service.postResponse(NetworkUrls.LOGIN, body, headers);

      if(response.statusCode == 200){
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        responseData = responseBody;
      }

    }catch (e) {
      if(kDebugMode){
        log("message" + e.toString());
      }
    }
    return responseData;
  }
}