import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:india_club/Helpers/utils.dart';
import 'package:india_club/HomePage/dashboard.dart';
import 'package:india_club/Src/Repository/sports_repo.dart';

import '../../Helpers/colors.dart';

class SportsBookingProvider with ChangeNotifier {
  SportsBookingRepo _bookingRepo = SportsBookingRepo();

  bool isLoading = false;
  dynamic sportsList;
  dynamic courtList;
  dynamic slot_availability;
  dynamic courtBooking;
  dynamic bookingHistory;
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
    if(courtBooking.containsKey("result")){
      setBookingHistory();
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
                    "Thank You!",
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "Booking Successful!",
                    style: GoogleFonts.poppins(fontSize: 12.sp),
                  ),
                  Text(
                    "Booking Number: ${courtBooking["result"]["data"]["booking_id"].toString()}",
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
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Dashboard()), (route) => false); // Close the dialog box
                    },
                    child: Text('Go Back'),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }else{
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
                    "Thank You!",
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "Booking Not Successful!",
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
                      Navigator.pop(context); // Close the dialog box
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
    setIsLoading(false);
  }

  setBookingHistory() async {
    setIsLoading(true);
    bookingHistory = await _bookingRepo.getBookingDetails();
    log("message" + bookingHistory.toString());
    notifyListeners();
    setIsLoading(false);
  }

}
