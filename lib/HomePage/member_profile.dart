import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:india_club/Helpers/utils.dart';

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
        title: Text("Profile", style: GoogleFonts.poppins(
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
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5.h,),
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
                ],
              ),
            ),
            Divider(indent: 10.w,endIndent: 10.w,),
            SizedBox(height: 3.h,),
            Container(
              width: getWidth(context),
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: ColorPellets.orange.withOpacity(0.07)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Dependencies", style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600
                  ),),
                  SizedBox(height: 6.h,),
                  Text("Name : ", style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 11.sp,
                      color: Colors.black.withOpacity(0.6),
                  ),),
                  SizedBox(height: 3.h,),
                  Text("Relation : ",style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 11.sp,
                    color: Colors.black.withOpacity(0.6),
                  ),),
                  SizedBox(height: 12.h,),
                  Text("Name : ", style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 11.sp,
                    color: Colors.black.withOpacity(0.6),
                  ),),
                  SizedBox(height: 3.h,),
                  Text("Relation : ",style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 11.sp,
                    color: Colors.black.withOpacity(0.6),
                  ),),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
