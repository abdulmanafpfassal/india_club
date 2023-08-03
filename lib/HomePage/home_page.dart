import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:india_club/Helpers/colors.dart';
import 'package:india_club/Helpers/utils.dart';
import 'package:india_club/HomePage/court_booking.dart';
import 'package:india_club/HomePage/member_profile.dart';

import '../Notification/notification_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("India Club", style: GoogleFonts.poppins(
          color: Colors.black
        ),),
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
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.w),
        child: ListView(
          children: [
            SizedBox(height: 10.h,),
            Container(
              width: getWidth(context),
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: ColorPellets.orange.withOpacity(0.07)
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(200.r),
                        child: Image.asset("assets/images/dummy.jpg", height: 60.h,),
                      ),
                      SizedBox(width: 10.w,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Full Name: ",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 11.sp,
                                color: Colors.black.withOpacity(0.6)),
                          ),
                          Text(
                            "Member ID: ",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 11.sp,
                                color: Colors.black.withOpacity(0.6)),
                          ),
                          Text(
                            "Phone: ",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 11.sp,
                                color: Colors.black.withOpacity(0.6)),
                          ),
                          Text(
                            "Address: ",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 11.sp,
                                color: Colors.black.withOpacity(0.6)),
                          ),
                        ],
                      )
                    ],
                  ),
                  Center(
                    child: Text("View more >", style: GoogleFonts.poppins(
                      color: Colors.orange
                    ),),
                  )
                ],
              ),
            ),

            SizedBox(
              height: 70.h,
            ),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "India Club",
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => MemberProfile()));
                    },
                    child: Container(
                      width: getWidth(context),
                      height: 30.h,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10.r)
                      ),
                      child: Center(child: Text("Member Details")),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => CourtBooking()));
                    },
                    child: Container(
                      width: getWidth(context),
                      height: 30.h,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10.r)
                      ),
                      child: Center(child: Text("Court Booking")),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
