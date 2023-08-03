import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:india_club/Notification/notification_page.dart';
import 'package:india_club/Widget/custom_button.dart';
import 'package:intl/intl.dart';

import '../Helpers/utils.dart';

class CourtBooking extends StatefulWidget {
  const CourtBooking({super.key});

  @override
  State<CourtBooking> createState() => _CourtBookingState();
}

class _CourtBookingState extends State<CourtBooking> {
  String? selectedSport;
  String? selectedTime;
  DateTime selectedDate = DateTime.now();

  List<String> sportsItems = [
    'Football',
    'Basketball',
    'Tennis',
    'Cricket',
    'Baseball',
    'Soccer',
    'Volleyball',
    'Hockey',
  ];

  List<String> selectedTimeList = [
    '07:00 - 08:00AM',
    '08:00 - 09:00AM',
    '09:00 - 10:00AM',
    '10:00 - 11:00AM',
    '11:00 - 12:00PM',
    '12:00 - 01:00PM',
    '01:00 - 02:00PM',
    '03:00 - 04:00PM',
  ];

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd MMM yyyy').format(selectedDate);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Booking", style: GoogleFonts.poppins(
            color: Colors.black
        ),),
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
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => NotificationPage()));
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
      body: Stack(
        children: [
          Image.asset(
            "assets/images/truf.jpg",
            fit: BoxFit.cover,
            height: getHeight(context),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Member Full Name: ",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 13.sp,
                          color: Colors.white),
                    ),
                    Text(
                      "Member ID: ",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 13.sp,
                          color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(height: 20.h,),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Column(
                    children: [
                      Container(
                        width: getWidth(context),
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.r)
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: selectedSport,
                            onChanged: (newValue) {
                              setState(() {
                                selectedSport = newValue!;
                              });
                            },
                            hint: Text("Select Sports", style: GoogleFonts.poppins(
                                fontSize: 12.sp,
                                color: Colors.black.withOpacity(0.7)
                            ),),
                            items: sportsItems.map((sport) {
                              return DropdownMenuItem<String>(
                                value: sport,
                                child: Text(sport),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h,),
                      InkWell(
                        onTap: (){
                          _selectDate(context);
                        },
                        child: Container(
                          width: getWidth(context),
                          height: 35.h,
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.r)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(formattedDate.toString(), style: GoogleFonts.poppins(
                                  fontSize: 12.sp,
                                  color: Colors.black.withOpacity(0.7)
                              ),),
                              Icon(IconlyLight.calendar)
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h,),
                      Container(
                        width: getWidth(context),
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.r)
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: selectedTime,
                            onChanged: (newValue) {
                              setState(() {
                                selectedTime = newValue!;
                              });
                            },
                            hint: Text("Select Time", style: GoogleFonts.poppins(
                                fontSize: 12.sp,
                                color: Colors.black.withOpacity(0.7)
                            ),),
                            items: selectedTimeList.map((sport) {
                              return DropdownMenuItem<String>(
                                value: sport,
                                child: Text(sport),
                              );
                            }).toList(),
                            borderRadius: BorderRadius.circular(10.r),
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h,),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.w),
                  child: CustomButton(button_text: "Book Now", onTap: (){
                    _showDialogBox(context);
                  }, isEnabled: true,),
                )
              ],
            ),
          )
        ],
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
                SizedBox(height: 10.h,),
                Text("Booking Successful!", style: GoogleFonts.poppins(
                  fontSize: 12.sp
                ),),
                Text("Booking Number: BKNG20230803", style: GoogleFonts.poppins(
                    fontSize: 12.sp
                ),),
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
