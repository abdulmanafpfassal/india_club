import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:india_club/Src/Repository/sports_repo.dart';

class SportsBookingProvider with ChangeNotifier {
  SportsBookingRepo _bookingRepo = SportsBookingRepo();

  bool isLoading = false;
  dynamic sportsList;
  dynamic courtList;
  dynamic slot_availability;
  var activity_id;
  var date;

  setIsLoading(bool flag){
    isLoading = flag;
    notifyListeners();
  }

  setActivityId(String text){
    activity_id = text;
  }

  setDate(String text){
    date = text;
    print(date);
  }

  setSportsList() async {
    setIsLoading(true);
    sportsList = await _bookingRepo.getAllSports();
    setIsLoading(false);
    notifyListeners();
  }

  setCourtList() async {
    setIsLoading(true);
    if(courtList != null){
      courtList.clear();
    }
    courtList = await _bookingRepo.getCourt();

    for (var data in courtList["data"]) {
      var slotAvailability = await _bookingRepo.getCourtSlot(data["id"].toString());
      data["slot_availability"] = slotAvailability["data"]["available_slots"];
    }

    log(courtList.toString());
    setIsLoading(false);

    notifyListeners();
  }


}