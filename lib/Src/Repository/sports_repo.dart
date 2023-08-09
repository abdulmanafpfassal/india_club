
import 'dart:convert';
import 'dart:developer';

import 'package:india_club/Helpers/network.dart';
import 'package:india_club/Helpers/utils.dart';
import 'package:india_club/Src/Provider/sports_provider.dart';
import 'package:india_club/Src/WebService/webService.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SportsBookingRepo {
  ApiService _service = ApiService();

  Future<Map<String, dynamic>> getAllSports() async{
    Map<String, dynamic> responseData = {};
    try{
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var session_id = preferences.getString("session");

      print("session"+session_id.toString());

      Map<String, String> headers = {
        'Content-Type': 'application/json',
        "X-Openerp-Session-id": "$session_id"
      };

      final response = await _service.getResponse(NetworkUrls.GET_ALL_SPORTS, headers);

      if(response.statusCode == 200){
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        responseData = responseBody;
        log("message" + responseData.toString());
      }

    }catch(e){
      log(e.toString());
    }
    return responseData;
  }

  Future<Map<String, dynamic>> getCourt() async {
    Map<String, dynamic> responseData = {};
    try{
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var session_id = preferences.getString("session");

      print("session"+session_id.toString());

      Map<String, String> headers = {
        'Content-Type': 'application/json',
        "X-Openerp-Session-id": "$session_id"
      };
      var id = getContext.navigatorKey.currentContext!.read<SportsBookingProvider>().activity_id;

      final response = await _service.getResponse(NetworkUrls.GET_COURT + id.toString(), headers);


      if(response.statusCode == 200){
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        log(responseBody.toString());
        responseData = responseBody;
      }
    }catch (e) {
      log(e.toString());
    }
    return responseData;
  }

  Future<Map<String, dynamic>> getCourtSlot(String courtId) async {
    Map<String, dynamic> responseData = {};
    try{
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var session_id = preferences.getString("session");

      print("session"+session_id.toString());

      Map<String, String> headers = {
        'Content-Type': 'application/json',
        "X-Openerp-Session-id": "$session_id"
      };
      var date = getContext.navigatorKey.currentContext!.read<SportsBookingProvider>().date;

      final response = await _service.getResponse(NetworkUrls.GET_SLOT + courtId + "&booking_date=" + date, headers);

      if(response.statusCode == 200){
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        responseData = responseBody;
      }
    }catch (e) {
      log(e.toString());
    }
    return responseData;
  }
}