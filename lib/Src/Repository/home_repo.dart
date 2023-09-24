
import 'dart:convert';
import 'dart:developer';

import 'package:india_club/Src/WebService/webService.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Helpers/network.dart';

class HomeRepo {
  ApiService _service = ApiService();

  Future<Map<String, dynamic>> getBannerImages() async {
    Map<String, dynamic> responseData = {};
    try{
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var session_id = preferences.getString("session");
      var uid = preferences.getInt("uid");


      Map<String, String> headers = {
        'Content-Type': 'application/json',
        "X-Openerp-Session-id": "$session_id"
      };

      final response = await _service.getResponse(NetworkUrls.banner_images + uid.toString(), headers);

      if(response.statusCode == 200){
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        responseData = responseBody;
      }

    }catch (e){
      log(e.toString());
    }
    return responseData;
  }
}