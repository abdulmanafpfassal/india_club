import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:india_club/Helpers/colors.dart';
import 'package:india_club/Helpers/utils.dart';
import 'package:india_club/Bookings/court_booking.dart';
import 'package:india_club/HomePage/member_profile.dart';
import 'package:india_club/Widget/custom_button.dart';

import '../Notification/notification_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index1 = -1;
  int index2 = -1;
  int index3 = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        title: Text(
          "India Club",
          style: GoogleFonts.poppins(color: Colors.black),
        ),
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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.white,Colors.white,Colors.white, Color(0xFFFDE7CA),Color(0xFFFBCB8D),Color(0xFFFBCB8D), Color(0xFFFBCB8D)],
          ),
        ),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10.w),
          child: ListView(
            shrinkWrap: true,
            children: [
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
                    InkWell(
                      onTap: (){
                        showModalBottomSheet(
                            context: context, builder: (ctx) => dialogBox());
                      },
                      child: Center(
                        child: Text(
                          "View more >",
                          style: GoogleFonts.poppins(color: Colors.orange),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Court Booking",
                      style: GoogleFonts.poppins(
                          fontSize: 12.sp, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: (){
                              setState(() {
                                index1 = 0;
                              });
                            },
                            child: Container(
                              width: 150.w,
                              height: 40.h,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: index1 == 0 ? ColorPellets.orange : Colors.grey.withOpacity(0.3)),
                                  borderRadius: BorderRadius.circular(10.r)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 70,
                                    decoration: BoxDecoration(
                                        color: Colors.greenAccent.withOpacity(0.4),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10.r),
                                            bottomLeft: Radius.circular(10.r))),
                                    child: Center(
                                      child: Image.asset(
                                        "assets/images/football.png",
                                        height: 25.h,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Football",
                                    style: GoogleFonts.poppins(
                                        fontSize: 11.sp, fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox()
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          InkWell(
                            onTap: (){
                              setState(() {
                                index1 = 1;
                              });
                            },
                            child: Container(
                              width: 150.w,
                              height: 40.h,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: index1 == 1 ? ColorPellets.orange : Colors.grey.withOpacity(0.3)),
                                  borderRadius: BorderRadius.circular(10.r)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 70,
                                    decoration: BoxDecoration(
                                        color: Colors.redAccent.withOpacity(0.4),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10.r),
                                            bottomLeft: Radius.circular(10.r))),
                                    child: Center(
                                      child: Image.asset(
                                        "assets/images/golf.png",
                                        height: 25.h,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Golf",
                                    style: GoogleFonts.poppins(
                                        fontSize: 11.sp, fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox()
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          InkWell(
                            onTap: (){
                              setState(() {
                                index1 = 2;
                              });
                            },
                            child: Container(
                              width: 150.w,
                              height: 40.h,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: index1 == 2 ? ColorPellets.orange : Colors.grey.withOpacity(0.3)),
                                  borderRadius: BorderRadius.circular(10.r)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 70,
                                    decoration: BoxDecoration(
                                        color: Colors.orange.withOpacity(0.4),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10.r),
                                            bottomLeft: Radius.circular(10.r))),
                                    child: Center(
                                      child: Image.asset(
                                        "assets/images/cricket.png",
                                        height: 25.h,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Cricket",
                                    style: GoogleFonts.poppins(
                                        fontSize: 11.sp, fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox()
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
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
                    Container(
                      height: 55.h,
                      child: ListView.separated(
                        separatorBuilder: (ctx, ind){
                          return SizedBox(width: 10.w,);
                        },
                        itemCount: 31,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                        return InkWell(
                          onTap: (){
                            setState(() {
                              index2 = index;
                            });
                          },
                          child: Container(
                            width: 55.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                                border: Border.all(color: index2 == index ? ColorPellets.orange : Colors.grey.withOpacity(0.3)),
                                borderRadius: BorderRadius.circular(10.r)),
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  index < 9 ? Text(
                                    "0${index+1}",
                                    style: GoogleFonts.poppins(
                                        fontSize: 13.sp, fontWeight: FontWeight.w500),
                                  ) : Text(
                                    "${index+1}",
                                    style: GoogleFonts.poppins(
                                        fontSize: 13.sp, fontWeight: FontWeight.w500),
                                  ),
                                  Text("Aug")
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "Time",
                      style: GoogleFonts.poppins(fontSize: 11.sp),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      height: 30.h,
                      child: ListView.separated(
                          separatorBuilder: (ctx, ind){
                            return SizedBox(width: 10.w,);
                          },
                          itemCount: 6,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: (){
                                setState(() {
                                  index3 = index;
                                });
                              },
                              child: Container(
                                width: 150.w,
                                height: 30.h,
                                decoration: BoxDecoration(
                                    border: Border.all(color: index == index3 ? ColorPellets.orange : Colors.grey.withOpacity(0.3)),
                                    borderRadius: BorderRadius.circular(10.r)),
                                child: Center(
                                  child:Text("0${index+1}: 00 PM - 0${index+2}: 00PM" ),
                                ),
                              ),
                            );
                          }),
                    ),
                    SizedBox(height: 180.h,),
                    Container(
                        margin: EdgeInsets.symmetric( vertical: 20.h),
                        child: CustomButton(button_text: "Book Now",onTap: (){},isEnabled: true,))
                    // SizedBox(
                    //   height: 10.h,
                    // ),
                    // Text(
                    //   "Hour",
                    //   style: GoogleFonts.poppins(fontSize: 11.sp),
                    // ),
                    // SizedBox(
                    //   height: 10.h,
                    // ),
                    // Container(
                    //   height: 55.h,
                    //   child: ListView.separated(
                    //       separatorBuilder: (ctx, ind){
                    //         return SizedBox(width: 10.w,);
                    //       },
                    //       itemCount: 10,
                    //       shrinkWrap: true,
                    //       scrollDirection: Axis.horizontal,
                    //       physics: BouncingScrollPhysics(),
                    //       itemBuilder: (context, index) {
                    //         return Container(
                    //           width: 55.w,
                    //           height: 40.h,
                    //           decoration: BoxDecoration(
                    //               border: Border.all(color: index == 2 ? ColorPellets.orange : Colors.grey.withOpacity(0.3)),
                    //               borderRadius: BorderRadius.circular(10.r)),
                    //           child: Center(
                    //             child: Column(
                    //               crossAxisAlignment: CrossAxisAlignment.center,
                    //               mainAxisAlignment: MainAxisAlignment.center,
                    //               children: [
                    //                 Text(
                    //                   "0${index+1}",
                    //                   style: GoogleFonts.poppins(
                    //                       fontSize: 13.sp, fontWeight: FontWeight.w500),
                    //                 ),
                    //               ],
                    //             ),
                    //           ),
                    //         );
                    //       }),
                    // ),
                    // SizedBox(height: 20.h,),
                    // Center(
                    //   child: Column(
                    //     children: [
                    //       Text("Grand Total", style: GoogleFonts.poppins(
                    //         fontSize: 12.sp,
                    //         fontWeight: FontWeight.w500
                    //       ),),
                    //       Text("50 AED")
                    //     ],
                    //   ),
                    // )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  dialogBox() {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Dependencies", style: GoogleFonts.poppins(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500
          ),),
          SizedBox(height: 20.h,),
          Text(
            "Name: ",
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 11.sp,
                color: Colors.black.withOpacity(0.6)),
          ),
          Text(
            "Relation: ",
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 11.sp,
                color: Colors.black.withOpacity(0.6)),
          ),
          SizedBox(height: 10.h,),
          Text(
            "Name: ",
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 11.sp,
                color: Colors.black.withOpacity(0.6)),
          ),
          Text(
            "Relation: ",
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 11.sp,
                color: Colors.black.withOpacity(0.6)),
          ),
        ],
      ),
    );
  }
}
