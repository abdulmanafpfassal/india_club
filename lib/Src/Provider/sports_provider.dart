import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:india_club/Src/Repository/sports_repo.dart';

class SportsBookingProvider with ChangeNotifier {
  SportsBookingRepo _bookingRepo = SportsBookingRepo();

  dynamic sportsList;
  dynamic courtList;
  dynamic slot_availability;
  var activity_id;
  var date;

  setActivityId(String text){
    activity_id = text;
  }

  setDate(String text){
    date = text;
    print(date);
  }

  setSportsList() async {
    sportsList = await _bookingRepo.getAllSports();
    notifyListeners();
  }

  setCourtList() async {
    courtList = await _bookingRepo.getCourt();

    for (var data in courtList["data"]) {
      var slotAvailability = await _bookingRepo.getCourtSlot(data["id"].toString());
      data["slot_availability"] = slotAvailability["data"]["available_slots"];
    }

    log(courtList.toString());

    notifyListeners();
  }


}