import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:india_club/Src/Repository/sports_repo.dart';

import '../../Helpers/colors.dart';

class SportsBookingProvider with ChangeNotifier {
  SportsBookingRepo _bookingRepo = SportsBookingRepo();

  bool isLoading = false;
  dynamic sportsList;
  dynamic courtList;
  dynamic slot_availability;
  dynamic courtBooking;
  var activity_id;
  var date;
  Color selection_color = ColorPellets.orange.withOpacity(0.6);
  Color selectedTextColor = Colors.white;
  DateTime selectedDate = DateTime.now();
  int guestNumber = 0;
  int memberNumber = 0;

  var userId;
  var memberId;
  var emailId;
  var courtId;
  var gender;
  var gsm = "";
  var date_from;
  var slotId;
  var booking_date;
  var membershipId;


  setUser(int id){
    userId = id;
  }

  setMemberId(int id){
    memberId = id;
  }

  setEmail(String text){
    emailId = text;
  }


  setCourtId(int id){
    courtId = id;
  }

  setGender(var text){
    print(text);
    if(text == false){
      gender = "";
    }else{
      gender = text;
    }
  }

  setDateFrom(String text) {
    date_from = text;
    booking_date = text;
  }

  setSlotId(int id){
    slotId = id;
  }

  setMembershipId(String id){
    membershipId = id;
  }

  incrementGuest(){
    guestNumber = guestNumber+1;
    notifyListeners();
  }

  decrementGuest(){
    if(guestNumber != 0) {
      guestNumber = guestNumber - 1;
      notifyListeners();
    }
  }

  incrementMem(){
    memberNumber = memberNumber+1;
    notifyListeners();
  }

  decrementMem(){
    if(memberNumber != 0) {
      memberNumber = memberNumber - 1;
      notifyListeners();
    }
  }

  setData(DateTime date){
    selection_color = ColorPellets.orange.withOpacity(0.6);
    selectedTextColor = Colors.white;
    selectedDate = date;
    notifyListeners();
  }

  setIsLoading(bool flag) {
    isLoading = flag;
    notifyListeners();
  }

  setActivityId(String text) {
    activity_id = text;
  }

  setDate(String text) {
    date = text;
    print(date);
  }

  setSportsList() async {
    setIsLoading(true);
    sportsList = await _bookingRepo.getAllSports();
    setIsLoading(false);
    notifyListeners();
  }

  clearCourtList(){
    if (courtList != null) {
      courtList = null;
    }
  }

  setIsSelectedToTrue(int id, String court) {
    if(courtList != null){
      for (var data = 0; data < courtList["data"].length; data++) {
        if(courtList["data"][data]["name"] == court){
          for (var index = 0; index < courtList["data"][data]["slot_availability"].length; index++) {
            if(courtList["data"][data]["slot_availability"][index]["id"] == id){
              courtList["data"][data]["slot_availability"][index]["isSelected"] = true;
              notifyListeners();
            }else{
              courtList["data"][data]["slot_availability"][index]["isSelected"] = false;
              notifyListeners();
            }
          }
        }
      }
    }
  }

  clearSelectedList(String court){
    if(courtList != null){
      for (var data = 0; data < courtList["data"].length; data++) {
        if(courtList["data"][data]["name"] == court){
          for (var index = 0; index < courtList["data"][data]["slot_availability"].length; index++) {
              courtList["data"][data]["slot_availability"][index]["isSelected"] = false;
              notifyListeners();
            }
          }
        }
      }
    }


  setCourtList() async {
    setIsLoading(true);

    clearCourtList();

    courtList = await _bookingRepo.getCourt();

    for (var data in courtList["data"]) {
      var slotAvailability = await _bookingRepo.getCourtSlot(data["id"].toString());
      data["slot_availability"] = slotAvailability["data"]["available_slots"];

      for (var newData in data["slot_availability"]) {
        newData["isSelected"] = false; // Fix the assignment here
      }
    }

    log(courtList.toString());

    setIsLoading(false); // Make sure to set isLoading to false after updating courtList
  }

  doCreateBooking() async {
    setIsLoading(true);
    courtBooking = await _bookingRepo.createBooking();
    setIsLoading(false);
  }

}
