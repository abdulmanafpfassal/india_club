import 'dart:developer';

import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:india_club/Bookings/booking_time.dart';
import 'package:india_club/Notification/notification_page.dart';
import 'package:india_club/Src/Provider/sports_provider.dart';
import 'package:india_club/Widget/custom_button.dart';
import 'package:intl/intl.dart';
import 'package:m_toast/m_toast.dart';
import 'package:provider/provider.dart';

import '../Helpers/colors.dart';
import '../Helpers/utils.dart';
import '../Widget/date_picker.dart';

class CourtBooking extends StatefulWidget {
  const CourtBooking({super.key});

  @override
  State<CourtBooking> createState() => _CourtBookingState();
}

class _CourtBookingState extends State<CourtBooking> {
  String? selectedSport;
  String? selectedTime;
  DateTime selectedDate = DateTime.now();
  int index1 = -1;
  DatePickerController dateController = DatePickerController();

  String formattedDate = DateFormat('dd MMM yyyy').format(DateTime.now());



  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
        _updateSelectedDate(pickedDate);
    }
  }

  void _updateSelectedDate(DateTime newDate) {
    log(">>>>>>>" + newDate.toString());
    setState(() {
      selectedDate = newDate;
      formattedDate = DateFormat('dd MMM yyyy').format(newDate);
      // dateController.animateToDate(selectedDate);
    });
    getContext.navigatorKey.currentContext!.read<SportsBookingProvider>().setDate(DateFormat('MM/dd/yyyy').format(selectedDate));
  }

  @override
  void initState() {
    selectedDate = DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
    Future.delayed(Duration(seconds: 0), () {
      getContext.navigatorKey.currentContext!.read<SportsBookingProvider>().setDate(DateFormat('MM/dd/yyyy').format(selectedDate));
    });
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Booking",
          style: GoogleFonts.poppins(color: Colors.black),
        ),
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              IconlyLight.arrow_left_2,
              color: Colors.black,
            )),
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => NotificationPage()));
            },
            child: Icon(
              IconlyLight.notification,
              color: Colors.black,
            ),
          ),
          SizedBox(
            width: 20.w,
          ),
          InkWell(
            onTap: () {
              showModalBottomSheet(
                  context: context, builder: (ctx) => LogoutDialog());
            },
            child: Icon(
              IconlyLight.logout,
              color: Colors.red,
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomHorizontalDatePicker(
              selectedTextColor: Colors.white,
              selectionColor: ColorPellets.orange.withOpacity(0.6),
              initialSelectedDate: selectedDate,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "Date",
                    style: GoogleFonts.poppins(fontSize: 11.sp),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  InkWell(
                    onTap: () {
                      _selectDate(context);
                    },
                    child: Container(
                      width: getWidth(context),
                      height: 35.h,
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r),
                          border:
                              Border.all(color: Colors.grey.withOpacity(0.3))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            formattedDate.toString(),
                            style: GoogleFonts.poppins(
                                fontSize: 12.sp,
                                color: Colors.black.withOpacity(0.7)),
                          ),
                          Icon(IconlyLight.calendar)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  InkWell(
                    onTap: () {
                      if(index1 != -1) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => BookingTime()));
                      }else{
                        Future.delayed(Duration(seconds: 0), () {
                          ShowMToast().errorToast(context, message: "Select a sport", alignment: Alignment.bottomCenter);
                        });
                      }
                    },
                    child: Text(
                      "Check Availability",
                      style: GoogleFonts.poppins(
                          fontSize: 11.sp,
                          color: ColorPellets.orange,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  // Container(
                  //   width: getWidth(context),
                  //  // padding: EdgeInsets.symmetric(horizontal: 10.w),
                  //   decoration: BoxDecoration(
                  //       color: Colors.white,
                  //       borderRadius: BorderRadius.circular(10.r),
                  //       border: Border.all(color: Colors.grey.withOpacity(0.3))
                  //   ),
                  //   child: DropdownButtonHideUnderline(
                  //     child: DropdownButton<String>(
                  //       isExpanded: true,
                  //       value: selectedTime,
                  //       onChanged: (newValue) {
                  //         setState(() {
                  //           selectedTime = newValue!;
                  //         });
                  //       },
                  //       hint: Text("Select Time", style: GoogleFonts.poppins(
                  //           fontSize: 12.sp,
                  //           color: Colors.black.withOpacity(0.7)
                  //       ),),
                  //       items: selectedTimeList.map((sport) {
                  //         return DropdownMenuItem<String>(
                  //           value: sport,
                  //           child: Text(sport),
                  //         );
                  //       }).toList(),
                  //       borderRadius: BorderRadius.circular(10.r),
                  //       padding: EdgeInsets.symmetric(horizontal: 10.w),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.w),
              child: CustomButton(
                button_text: "Book Now",
                onTap: () {
                  _showDialogBox(context);
                },
                isEnabled: true,
              ),
            )
          ],
        ),
      ),
    );
  }

  _showDialogBox(BuildContext context) {
    showDialog(
      context: context,
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
                  "Booking Number: BKNG20230803",
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
                    Navigator.of(context).pop(); // Close the dialog box
                  },
                  child: Text('Go Back'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }



}
