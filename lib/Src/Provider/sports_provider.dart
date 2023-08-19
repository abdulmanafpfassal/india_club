import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:india_club/Helpers/utils.dart';
import 'package:india_club/HomePage/dashboard.dart';
import 'package:india_club/Src/Provider/notification_provider.dart';
import 'package:india_club/Src/Repository/sports_repo.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Helpers/colors.dart';

class SportsBookingProvider with ChangeNotifier {
  SportsBookingRepo _bookingRepo = SportsBookingRepo();

  bool isLoading = false;
  dynamic sportsList1;
  dynamic sportsList2;
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
  var sportsName;

  setSportsName(String name) {
    sportsName = name;
    notifyListeners();
  }


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

  clearCourtIdAndSlot(){
    courtId = null;
    slotId = null;
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
    sportsList1 = {
      "message": "All Games have been fetched successfully",
      "status": true,
      "status_code": 200,
      "data": [
        {
          "id": 4,
          "sequence": "SP00001",
          "activity": "TENNIS",
          "activity_type": "games",
          "court_ids": null,
          "company_id": 1,
          "company_name": "India Club Dubai",
          "icon": "assets/images/tennis.png"
        },
        {
          "id": 3,
          "sequence": "SP00002",
          "activity": "BADMINTON",
          "activity_type": "games",
          "court_ids": null,
          "company_id": 1,
          "company_name": "India Club Dubai",
          "icon": "assets/images/badminton.png"
        },
        {
          "id": 1,
          "sequence": "SP00004",
          "activity": "CRICKET",
          "activity_type": "games",
          "court_ids": null,
          "company_id": 1,
          "company_name": "India Club Dubai",
          "icon": "assets/images/cricket.png"
        },
      ]
    };
    sportsList2 = {
      "message": "All Games have been fetched successfully",
      "status": true,
      "status_code": 200,
      "data": [
        {
          "id": 2,
          "sequence": "SP00005",
          "activity": "FOOTBALL",
          "activity_type": "games",
          "court_ids": null,
          "company_id": 1,
          "company_name": "India Club Dubai",
          "icon": "assets/images/football.png"
        },
        {
          "id": 5,
          "sequence": "SP00006",
          "activity": "SQUASH",
          "activity_type": "games",
          "court_ids": null,
          "company_id": 1,
          "company_name": "India Club Dubai",
          "icon": "assets/images/squash.png"
        }
      ]
    };
    // sportsList1 = {
    //   "message": "All Games have been fetched successfully",
    //   "status": true,
    //   "status_code": 200,
    //   "data": [
    //     {
    //       "id": 1,
    //       "sequence": "SP00001",
    //       "activity": "TENNIS",
    //       "activity_type": "games",
    //       "court_ids": null,
    //       "company_id": 1,
    //       "company_name": "India Club Dubai",
    //       "icon": "assets/images/tennis.png"
    //     },
    //     {
    //       "id": 2,
    //       "sequence": "SP00002",
    //       "activity": "BADMINTON",
    //       "activity_type": "games",
    //       "court_ids": null,
    //       "company_id": 1,
    //       "company_name": "India Club Dubai",
    //       "icon": "assets/images/badminton.png"
    //     },
    //     {
    //       "id": 4,
    //       "sequence": "SP00004",
    //       "activity": "CRICKET",
    //       "activity_type": "games",
    //       "court_ids": null,
    //       "company_id": 1,
    //       "company_name": "India Club Dubai",
    //       "icon": "assets/images/cricket.png"
    //     },
    //   ]
    // };
    // sportsList2 = {
    //   "message": "All Games have been fetched successfully",
    //   "status": true,
    //   "status_code": 200,
    //   "data": [
    //     {
    //       "id": 5,
    //       "sequence": "SP00005",
    //       "activity": "FOOTBALL",
    //       "activity_type": "games",
    //       "court_ids": null,
    //       "company_id": 1,
    //       "company_name": "India Club Dubai",
    //       "icon": "assets/images/football.png"
    //     },
    //     {
    //       "id": 6,
    //       "sequence": "SP00006",
    //       "activity": "SQUASH",
    //       "activity_type": "games",
    //       "court_ids": null,
    //       "company_id": 1,
    //       "company_name": "India Club Dubai",
    //       "icon": "assets/images/squash.png"
    //     }
    //   ]
    // };
    setIsLoading(false);
    notifyListeners();
  }

  clearCourtList(){
    if (courtList != null) {
      courtList = null;
    }
  }

  // setIsSelectedToTrue(int id, String court) {
  //   if(courtList != null){
  //     for (var data = 0; data < courtList["data"].length; data++) {
  //       if(courtList["data"][data]["name"] == court){
  //         for (var index = 0; index < courtList["data"][data]["slot_availability"].length; index++) {
  //           if(courtList["data"][data]["slot_availability"][index]["id"] == id){
  //             courtList["data"][data]["slot_availability"][index]["isSelected"] = true;
  //             notifyListeners();
  //           }else{
  //             for(var ind = 0; ind < courtList["data"].length; ind++){
  //               courtList["data"][ind]["slot_availability"][index]["isSelected"] = false;
  //               notifyListeners();
  //             }
  //           }
  //         }
  //       }
  //     }
  //   }
  // }
  void setIsSelectedToTrue(int id, String court) {
    if (courtList != null) {
      for (var data = 0; data < courtList["data"].length; data++) {
        if (courtList["data"][data]["name"] == court) {
          for (var index = 0; index < courtList["data"][data]["slot_availability"].length; index++) {
            if (courtList["data"][data]["slot_availability"][index]["id"] == id) {
              courtList["data"][data]["slot_availability"][index]["isSelected"] = true;
            } else {
              courtList["data"][data]["slot_availability"][index]["isSelected"] = false;
            }
          }
        } else {
          for (var index = 0; index < courtList["data"][data]["slot_availability"].length; index++) {
            courtList["data"][data]["slot_availability"][index]["isSelected"] = false;
          }
        }
      }
      notifyListeners();
    }
  }


  clearSelectedList(){
    if(courtList != null){
      for (var data = 0; data < courtList["data"].length; data++) {
          for (var index = 0; index < courtList["data"][data]["slot_availability"].length; index++) {
              courtList["data"][data]["slot_availability"][index]["isSelected"] = false;
              notifyListeners();
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

      log("message" + date.toString());
      log("message" + DateFormat('yyyy-MM-dd').format(DateTime.now()).toString());
      if(date == DateFormat('yyyy-MM-dd').format(DateTime.now())) {
        DateTime currentTime = DateTime.now();
        double currentHour = currentTime.hour + currentTime.minute / 60.0;

        data["slot_availability"].removeWhere((newData) {
          double startTime = newData["start_time"];
          return currentHour >=
              startTime; // Remove if the slot has already started
        });

        for (var newData in data["slot_availability"]) {
          newData["isSelected"] = false; // Fix the assignment here
        }
      }else{

        for (var newData in data["slot_availability"]) {
          newData["isSelected"] = false; // Fix the assignment here
        }
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
      if(courtBooking["result"]["data"].isNotEmpty) {
        getContext.navigatorKey.currentContext!
            .read<NotificationProvider>()
            .setNotification("Booking Confirmation",
            "Congratulations! Your court booking is Successful and your Booking Reference Number is ${courtBooking["result"]["data"]["booking_reference"]
                .toString()}");
      }
      showDialog(
        barrierDismissible: false,
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
                    "${courtBooking["result"]["message"].toString()}",
                    style: GoogleFonts.poppins(fontSize: 12.sp),
                  ),
                  courtBooking["result"]["data"].isNotEmpty ? Text(
                    "Booking Number: ${courtBooking["result"]["data"]["booking_reference"].toString()}",
                    style: GoogleFonts.poppins(fontSize: 12.sp),
                  ) : Text(""),
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
                    child: Text('Okay'),
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
                    "Failed!",
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
                      primary: Colors.red, // Set the background color to teal
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

  String profileImage = "";

  setProfile() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var uid = preferences.getInt("partnerId");
    profileImage = "https://members.indiaclubdubai.com/kg_mobile_api/static/profile_images/${uid}_start.jpg";
  }

}
