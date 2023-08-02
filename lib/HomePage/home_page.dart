import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:india_club/Helpers/utils.dart';
import 'package:india_club/HomePage/court_booking.dart';
import 'package:india_club/HomePage/member_profile.dart';

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
      appBar: getHomeAppBar(),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.w),
        child: ListView(
          children: [
            Text(
              "Member Full Name: ",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 13.sp,
                  color: Colors.black),
            ),
            Text(
              "Member ID: ",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 13.sp,
                  color: Colors.black),
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
