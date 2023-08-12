import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:india_club/Helpers/utils.dart';
import 'package:india_club/Src/Provider/authentication_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        backgroundColor: Colors.white,
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
      body: Consumer<AuthenticationProvider>(
        builder: (context, details, _) {
          return Container(
            margin: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5.h,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  width: getWidth(context),
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: ColorPellets.orange.withOpacity(0.07)),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(200.r),
                            child: Image.asset(
                              "assets/images/dummy.jpg",
                              height: 60.h,
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               Text(
                                "Member Name: ${details.memberDetails["data"][0]["name"]} ${details.memberDetails["data"][0]["surname"]}",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 11.sp,
                                    color: Colors.black.withOpacity(0.6)),
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              Text(
                                "Membership No: ${details.memberDetails["data"][0]["membership_no"]}",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 11.sp,
                                    color: Colors.black.withOpacity(0.6)),
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              Text(
                                details.memberDetails["data"][0]["phone"] == false ? "Phone number: " : "Phone number: ${details.memberDetails["data"][0]["phone"]}",
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
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(
                  indent: 10.w,
                  endIndent: 10.w,
                ),
                SizedBox(
                  height: 3.h,
                ),
                Container(
                  width: getWidth(context),
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: ColorPellets.orange.withOpacity(0.07)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "More Info",
                        style: GoogleFonts.poppins(
                            fontSize: 14.sp, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      Text(
                        details.memberDetails["data"][0]["whatsapp_no"] == false ? "Whatsapp: " : "Whatsapp: ${details.memberDetails["data"][0]["whatsapp_no"]}",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 11.sp,
                            color: Colors.black.withOpacity(0.6)),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Text(
                        "Email ID: ${details.memberDetails["data"][0]["email"]}",
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
                    ],
                  ),
                ),
                Divider(
                  indent: 10.w,
                  endIndent: 10.w,
                ),
                SizedBox(
                  height: 3.h,
                ),
                Container(
                  width: getWidth(context),
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: ColorPellets.orange.withOpacity(0.07)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Dependencies",
                        style: GoogleFonts.poppins(
                            fontSize: 14.sp, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      Container(
                        child: ListView.separated(
                          shrinkWrap: true,
                            itemCount: details.memberDetails["data"][0]["dependent_list"].length,
                            itemBuilder: (context, index) {
                              return details.memberDetails["data"][0]["dependent_list"].length >0  ?Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Name : ${details.memberDetails["data"][0]["dependent_list"][index]["name"]}",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 11.sp,
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
                                      fontSize: 11.sp,
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
                                      fontSize: 11.sp,
                                      color: Colors.black.withOpacity(0.6),
                                    ),
                                  ),
                                ],
                              ) : SizedBox();
                            },
                            separatorBuilder: (context, ind){
                              return SizedBox(height: 12.h,);
                            },
                            ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        }
      ),
    );
  }
}
