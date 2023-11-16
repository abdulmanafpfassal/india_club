import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:india_club/Bookings/booking_history.dart';
import 'package:india_club/HomePage/member_profile.dart';
import 'package:provider/provider.dart';

import '../Helpers/colors.dart';
import '../Helpers/utils.dart';
import '../Src/Provider/authentication_provider.dart';
import '../Src/Provider/sports_provider.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({super.key});

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: getWidth(context),
              height: getHeight(context) / 4,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: ColorPellets.orange.withOpacity(0.3),
                gradient: new LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [ColorPellets.orange.withOpacity(0.3), Colors.white],
                  stops: [0.8, 0.9],
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                            getContext.navigatorKey.currentContext!.read<SportsBookingProvider>().profileImage,
                            // height: 60.h,
                          ),
                          radius: 30.r,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Consumer<AuthenticationProvider>(
                            builder: (context, details, _) {
                          return details.memberDetails != null
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    details.memberDetails["data"][0]
                                                    ["surname"] ==
                                                null ||
                                            details.memberDetails["data"][0]
                                                    ["surname"] ==
                                                ""
                                        ? Text(
                                            details.memberDetails["data"][0]
                                                    ["name"]
                                                .toString(),
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 11.sp,
                                                color: Colors.black
                                                    .withOpacity(0.6)),
                                          )
                                        : Text(
                                            details.memberDetails["data"][0]
                                                        ["name"]
                                                    .toString() +
                                                " " +
                                                details.memberDetails["data"][0]
                                                        ["surname"]
                                                    .toString(),
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 11.sp,
                                                color: Colors.black
                                                    .withOpacity(0.6)),
                                          ),
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                    Text(
                                      "Member ID: ${details.memberDetails["data"][0]["membership_no"].toString()}",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11.sp,
                                          color: Colors.black.withOpacity(0.6)),
                                    ),
                                  ],
                                )
                              : Center(
                                  child: Text(
                                    "Loading...",
                                    style: GoogleFonts.poppins(
                                        color: Colors.grey, fontSize: 10.sp),
                                  ),
                                );
                        })
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              width: getWidth(context),
              child: Column(
                children: [
                  InkWell(
                    onTap: () async {
                      await Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MemberProfile()));
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        Icon(
                          IconlyLight.profile,
                          color: Colors.black,
                          size: 15.sp,
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "My Profile",
                                    style: GoogleFonts.poppins(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "View your Profile",
                                    style: GoogleFonts.poppins(
                                        color: Colors.grey, fontSize: 10.sp),
                                  )
                                ],
                              ),
                              Icon(
                                IconlyLight.arrow_right_2,
                                size: 16.sp,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Divider(
                    indent: 20.w,
                    endIndent: 20.w,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  InkWell(
                    onTap: () async {
                      await Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => BookingHistory()));
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        Icon(
                          IconlyLight.bookmark,
                          color: Colors.black,
                          size: 15.sp,
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Booking History",
                                    style: GoogleFonts.poppins(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "View your Bookings",
                                    style: GoogleFonts.poppins(
                                        color: Colors.grey, fontSize: 10.sp),
                                  )
                                ],
                              ),
                              Icon(
                                IconlyLight.arrow_right_2,
                                size: 16.sp,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Divider(
                    indent: 20.w,
                    endIndent: 20.w,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 30.h,
        child: Center(
          child: Text(
            "Version 1.0.5",
            style: GoogleFonts.poppins(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
