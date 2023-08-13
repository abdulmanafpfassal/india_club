import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:india_club/Helpers/utils.dart';
import 'package:india_club/Src/Provider/authentication_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Bookings/booking_history.dart';
import '../Helpers/colors.dart';
import '../Notification/notification_page.dart';

class MemberProfile extends StatefulWidget {
  const MemberProfile({super.key});

  @override
  State<MemberProfile> createState() => _MemberProfileState();
}

class _MemberProfileState extends State<MemberProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: ColorPellets.orange.withOpacity(0.07),
        elevation: 0,
        title: Text(
          "Profile",
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
        // actions: [
        //   InkWell(
        //     onTap: () {
        //       Navigator.of(context).push(
        //           MaterialPageRoute(builder: (context) => NotificationPage()));
        //     },
        //     child: Icon(
        //       IconlyLight.notification,
        //       color: Colors.black,
        //     ),
        //   ),
        //   SizedBox(
        //     width: 20.w,
        //   ),
        //   InkWell(
        //     onTap: () {
        //       showModalBottomSheet(
        //           context: context, builder: (ctx) => LogoutDialog());
        //     },
        //     child: Icon(
        //       IconlyLight.logout,
        //       color: Colors.red,
        //     ),
        //   ),
        //   SizedBox(
        //     width: 10.w,
        //   ),
        // ],
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset("assets/images/group.png"),
          ),
          Consumer<AuthenticationProvider>(builder: (context, details, _) {
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: getWidth(context),
                    padding: EdgeInsets.all(20.0),
                    decoration:
                        BoxDecoration(color: ColorPellets.orange.withOpacity(0.07)),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(200.r),
                          child: Image.asset(
                            "assets/images/dummy.jpg",
                            height: 60.h,
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "${details.memberDetails["data"][0]["name"]} ${details.memberDetails["data"][0]["surname"]}",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.sp,
                                  color: Colors.black.withOpacity(0.6)),
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Membership No: ",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 11.sp,
                                      color: Colors.black.withOpacity(0.6)),
                                ),
                                Text(
                                  "${details.memberDetails["data"][0]["membership_no"]}",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 11.sp,
                                      color: Colors.black.withOpacity(0.6)),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            Text(
                              details.memberDetails["data"][0]["email"] == false
                                  ? "email: "
                                  : "Email: ${details.memberDetails["data"][0]["email"]}",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 11.sp,
                                  color: Colors.black.withOpacity(0.6)),
                            ),
                            // SizedBox(
                            //   height: 3.h,
                            // ),
                            // Text(
                            //   "Membership Expiry: ",
                            //   style: GoogleFonts.poppins(
                            //       fontWeight: FontWeight.w500,
                            //       fontSize: 11.sp,
                            //       color: Colors.black.withOpacity(0.6)),
                            // ),
                            // SizedBox(
                            //   height: 3.h,
                            // ),
                            // Text(
                            //   "Email: ${details.memberDetails["data"][0]["email"]}",
                            //   style: GoogleFonts.poppins(
                            //       fontWeight: FontWeight.w500,
                            //       fontSize: 11.sp,
                            //       color: Colors.black.withOpacity(0.6)),
                            // ),
                            // SizedBox(
                            //   height: 3.h,
                            // ),
                            // Text(
                            //   "Address: ${details.memberDetails["data"][0]["address"]}",
                            //   style: GoogleFonts.poppins(
                            //       fontWeight: FontWeight.w500,
                            //       fontSize: 11.sp,
                            //       color: Colors.black.withOpacity(0.6)),
                            // ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                          context: context, builder: (context) => Profile());
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                IconlyLight.profile,
                                color: Colors.black,
                                size: 15.sp,
                              ),
                              SizedBox(
                                width: 6.w,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Profile",
                                    style: GoogleFonts.poppins(
                                        fontSize: 14.sp, fontWeight: FontWeight.w500),
                                  ),
                                  Text("View your Profile Data", style: GoogleFonts.poppins(
                                      color: Colors.grey,
                                      fontSize: 10.sp
                                  ),)
                                ],
                              ),
                            ],
                          ),
                          Icon(
                            IconlyLight.arrow_right_2,
                            color: Colors.grey,
                            size: 13.sp,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Divider(),
                  SizedBox(
                    height: 10.h,
                  ),
                  InkWell(

                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => BookingHistory()));
                      },

                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                IconlyLight.bookmark,
                                color: Colors.black,
                                size: 15.sp,
                              ),
                              SizedBox(
                                width: 4.w,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Booking History",
                                    style: GoogleFonts.poppins(
                                        fontSize: 14.sp, fontWeight: FontWeight.w500),
                                  ),
                                  Text("View your Bookings", style: GoogleFonts.poppins(
                                    color: Colors.grey,
                                    fontSize: 10.sp
                                  ),)
                                ],
                              ),
                            ],
                          ),
                          Icon(
                            IconlyLight.arrow_right_2,
                            color: Colors.grey,
                            size: 13.sp,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Divider(),
                  SizedBox(
                    height: 10.h,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => NotificationPage()));
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                IconlyLight.notification,
                                color: Colors.black,
                                size: 15.sp,
                              ),
                              SizedBox(
                                width: 6.w,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Notification",
                                    style: GoogleFonts.poppins(
                                        fontSize: 14.sp, fontWeight: FontWeight.w500),
                                  ),
                                  Text("Stay updated with personalized notifications", style: GoogleFonts.poppins(
                                      color: Colors.grey,
                                      fontSize: 10.sp
                                  ),)
                                ],
                              ),
                            ],
                          ),
                          Icon(
                            IconlyLight.arrow_right_2,
                            color: Colors.grey,
                            size: 13.sp,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Divider(),
                  SizedBox(
                    height: 10.h,
                  ),
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context, builder: (ctx) => LogoutDialog());
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                IconlyLight.logout,
                                color: Colors.red,
                                size: 13.sp,
                              ),
                              SizedBox(
                                width: 6.w,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Logout",
                                    style: GoogleFonts.poppins(
                                        fontSize: 14.sp, fontWeight: FontWeight.w500),
                                  ),
                                  Text("Sign out for account security", style: GoogleFonts.poppins(
                                      color: Colors.grey,
                                      fontSize: 10.sp
                                  ),)
                                ],
                              ),
                            ],
                          ),
                          Icon(
                            IconlyLight.arrow_right_2,
                            color: Colors.grey,
                            size: 13.sp,
                          )
                        ],
                      ),
                    ),
                  ),
                  // Container(
                  //   width: getWidth(context),
                  //   padding: EdgeInsets.all(10.0),
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(10.r),
                  //       color: ColorPellets.orange.withOpacity(0.07)),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Text(
                  //         "More Info",
                  //         style: GoogleFonts.poppins(
                  //             fontSize: 14.sp, fontWeight: FontWeight.w600),
                  //       ),
                  //       SizedBox(
                  //         height: 6.h,
                  //       ),
                  //       Text(
                  //         details.memberDetails["data"][0]["whatsapp_no"] == false
                  //             ? "Whatsapp: "
                  //             : "Whatsapp: ${details.memberDetails["data"][0]["whatsapp_no"]}",
                  //         style: GoogleFonts.poppins(
                  //             fontWeight: FontWeight.w500,
                  //             fontSize: 11.sp,
                  //             color: Colors.black.withOpacity(0.6)),
                  //       ),
                  //       SizedBox(
                  //         height: 3.h,
                  //       ),
                  //       Text(
                  //         "Email ID: ${details.memberDetails["data"][0]["email"]}",
                  //         style: GoogleFonts.poppins(
                  //             fontWeight: FontWeight.w500,
                  //             fontSize: 11.sp,
                  //             color: Colors.black.withOpacity(0.6)),
                  //       ),
                  //       SizedBox(
                  //         height: 3.h,
                  //       ),
                  //       Text(
                  //         "Membership Expiry: ",
                  //         style: GoogleFonts.poppins(
                  //             fontWeight: FontWeight.w500,
                  //             fontSize: 11.sp,
                  //             color: Colors.black.withOpacity(0.6)),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Divider(
                  //   indent: 10.w,
                  //   endIndent: 10.w,
                  // ),
                  // SizedBox(
                  //   height: 3.h,
                  // ),
                  // Container(
                  //   width: getWidth(context),
                  //   padding: EdgeInsets.all(10.0),
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(10.r),
                  //       color: ColorPellets.orange.withOpacity(0.07)),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Text(
                  //         "Dependencies",
                  //         style: GoogleFonts.poppins(
                  //             fontSize: 14.sp, fontWeight: FontWeight.w600),
                  //       ),
                  //       SizedBox(
                  //         height: 6.h,
                  //       ),
                  //       Container(
                  //         child: ListView.separated(
                  //           shrinkWrap: true,
                  //           itemCount: details
                  //               .memberDetails["data"][0]["dependent_list"].length,
                  //           itemBuilder: (context, index) {
                  //             return details
                  //                         .memberDetails["data"][0]
                  //                             ["dependent_list"]
                  //                         .length >
                  //                     0
                  //                 ? Column(
                  //                     crossAxisAlignment: CrossAxisAlignment.start,
                  //                     children: [
                  //                       Text(
                  //                         "Name : ${details.memberDetails["data"][0]["dependent_list"][index]["name"]}",
                  //                         style: GoogleFonts.poppins(
                  //                           fontWeight: FontWeight.w500,
                  //                           fontSize: 11.sp,
                  //                           color: Colors.black.withOpacity(0.6),
                  //                         ),
                  //                       ),
                  //                       SizedBox(
                  //                         height: 3.h,
                  //                       ),
                  //                       Text(
                  //                         "Age : ${details.memberDetails["data"][0]["dependent_list"][index]["age"]}",
                  //                         style: GoogleFonts.poppins(
                  //                           fontWeight: FontWeight.w500,
                  //                           fontSize: 11.sp,
                  //                           color: Colors.black.withOpacity(0.6),
                  //                         ),
                  //                       ),
                  //                       SizedBox(
                  //                         height: 3.h,
                  //                       ),
                  //                       Text(
                  //                         "Relation : ${details.memberDetails["data"][0]["dependent_list"][index]["dependent_type"]}",
                  //                         style: GoogleFonts.poppins(
                  //                           fontWeight: FontWeight.w500,
                  //                           fontSize: 11.sp,
                  //                           color: Colors.black.withOpacity(0.6),
                  //                         ),
                  //                       ),
                  //                     ],
                  //                   )
                  //                 : SizedBox();
                  //           },
                  //           separatorBuilder: (context, ind) {
                  //             return SizedBox(
                  //               height: 12.h,
                  //             );
                  //           },
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // )
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget Profile() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
      // height: getHeight(context) / 2,
      child: Consumer<AuthenticationProvider>(builder: (context, details, _) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  "More Info",
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 13.sp),
                ),
              ),
              Center(
                child: Container(
                  width: 40.w,
                  height: 3.h,
                  decoration: BoxDecoration(
                      color: ColorPellets.orange.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10.r)),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    details.memberDetails["data"][0]["whatsapp_no"] == false
                        ? "Whatsapp: "
                        : "Whatsapp: ${details.memberDetails["data"][0]["whatsapp_no"]}",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 11.sp,
                        color: Colors.black.withOpacity(0.6)),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Text(
                    "Membership Expiry: ",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 11.sp,
                        color: Colors.black.withOpacity(0.6)),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Text(
                    "Address: ${details.memberDetails["data"][0]["address"]}",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 11.sp,
                        color: Colors.black.withOpacity(0.6)),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              // Center(
              //   child: Text(
              //     "Address",
              //     style: GoogleFonts.poppins(
              //         color: Colors.black,
              //         fontWeight: FontWeight.bold,
              //         fontSize: 13.sp),
              //   ),
              // ),
              // Center(
              //   child: Container(
              //     width: 40.w,
              //     height: 3.h,
              //     decoration: BoxDecoration(
              //         color: ColorPellets.orange.withOpacity(0.3),
              //         borderRadius: BorderRadius.circular(10.r)),
              //   ),
              // ),
              // SizedBox(
              //   height: 10.h,
              // ),
              // Text(details.memberDetails["data"][0]["address"]),
              SizedBox(
                height: 10.h,
              ),
              Center(
                child: Text(
                  "Dependents",
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 13.sp),
                ),
              ),
              Center(
                child: Container(
                  width: 40.w,
                  height: 3.h,
                  decoration: BoxDecoration(
                      color: ColorPellets.orange.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10.r)),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount:
                    details.memberDetails["data"][0]["dependent_list"].length,
                itemBuilder: (context, index) {
                  return details.memberDetails["data"][0]["dependent_list"]
                              .length >
                          0
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Name : ${details.memberDetails["data"][0]["dependent_list"][index]["name"]}",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp,
                                color: Colors.black.withOpacity(0.6),
                              ),
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            Text(
                              "Age : ${details.memberDetails["data"][0]["dependent_list"][index]["age"]}",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp,
                                color: Colors.black.withOpacity(0.6),
                              ),
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            Text(
                              "Relation : ${details.memberDetails["data"][0]["dependent_list"][index]["dependent_type"]}",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp,
                                color: Colors.black.withOpacity(0.6),
                              ),
                            ),
                          ],
                        )
                      : SizedBox();
                },
                separatorBuilder: (context, ind) {
                  return SizedBox(
                    height: 12.h,
                  );
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
