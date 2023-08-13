import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:india_club/Helpers/utils.dart';
import 'package:india_club/Bookings/court_booking.dart';
import 'package:india_club/HomePage/member_profile.dart';
import 'package:india_club/Src/Provider/authentication_provider.dart';
import 'package:provider/provider.dart';

import '../Bookings/booking_history.dart';
import '../Bookings/sports_list.dart';
import '../Helpers/colors.dart';
import '../Notification/notification_page.dart';
import '../Src/Provider/sports_provider.dart';
import 'drawer.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentBannerIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  @override
  void initState() {
    Future.delayed(Duration(seconds: 0), () {
      getContext.navigatorKey.currentContext!
          .read<AuthenticationProvider>()
          .setMemberDetails();
      getContext.navigatorKey.currentContext!
          .read<SportsBookingProvider>()
          .setSportsList();
      getContext.navigatorKey.currentContext!
          .read<SportsBookingProvider>()
          .setBookingHistory();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: (){
            _scaffoldKey.currentState?.openDrawer();
          },
          child: Container(
            padding: EdgeInsets.all(15.0),
              child: Image.asset("assets/images/hamburger.png",)),
        ),
        elevation: 0,
        title: Text(
          "Home",
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
              size: 20.sp,
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
              size: 20.sp,
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: DrawerPage(),
      ),
      body: RefreshIndicator(
        color: ColorPellets.orange,
        onRefresh: () async {
          getContext.navigatorKey.currentContext!
              .read<AuthenticationProvider>()
              .setMemberDetails();
          getContext.navigatorKey.currentContext!
              .read<SportsBookingProvider>()
              .setSportsList();
          getContext.navigatorKey.currentContext!
              .read<SportsBookingProvider>()
              .setBookingHistory();
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10.w),
          child: ListView(
            children: [
              SizedBox(
                height: 10.h,
              ),
              CarouselSlider(
                options: CarouselOptions(
                  height: 140.h,
                  viewportFraction: 1,
                  autoPlay: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentBannerIndex = index;
                    });
                  },
                ),
                items: [
                  "assets/images/banner1.png",
                  "assets/images/banner2.png"
                ].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.r),
                            image: DecorationImage(
                                image: AssetImage(i), fit: BoxFit.cover)),
                      );
                    },
                  );
                }).toList(),
              ),
              SizedBox(
                height: 5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < 2; i++)
                    Container(
                      width: 6,
                      height: 6,
                      margin: EdgeInsets.symmetric(horizontal: 2.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentBannerIndex == i
                            ? ColorPellets
                                .orange // Change to the desired color for selected dot
                            : ColorPellets.orange.withOpacity(
                                0.2), // Change to the desired color for unselected dots
                      ),
                    ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                width: getWidth(context),
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  border:
                      Border.all(color: ColorPellets.orange.withOpacity(0.1)),
                ),
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
              SizedBox(
                height: 10.h,
              ),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(
                    //   "Categories",
                    //   style: GoogleFonts.poppins(
                    //     fontSize: 12.sp,
                    //     fontWeight: FontWeight.w500,
                    //     color: Colors.black.withOpacity(0.7)
                    //   ),
                    // ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => MemberProfile()));
                            },
                            child: Container(
                              height: 50.h,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: ColorPellets.orange
                                          .withOpacity(0.15)),
                                  borderRadius: BorderRadius.circular(10.r)),
                              child: Center(
                                  child: Row(
                                children: [
                                  Container(
                                    width: 50.w,
                                    height: 50.h,
                                    decoration: BoxDecoration(
                                        color: ColorPellets.orange
                                            .withOpacity(0.15),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10.r),
                                            bottomLeft: Radius.circular(10.r))),
                                    child: Center(
                                      child: Icon(
                                        IconlyLight.profile,
                                        color: ColorPellets.orange,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Member Details"),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Row(
                                        children: [
                                          Text("View"),
                                          Icon(
                                            IconlyLight.arrow_right_2,
                                            size: 12.sp,
                                            color: ColorPellets.orange,
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              )),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) => SportsList());
                            },
                            child: Container(
                              height: 50.h,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: ColorPellets.orange
                                          .withOpacity(0.15)),
                                  borderRadius: BorderRadius.circular(10.r)),
                              child: Center(
                                  child: Row(
                                children: [
                                  Container(
                                    width: 50.w,
                                    height: 50.h,
                                    decoration: BoxDecoration(
                                        color: ColorPellets.orange
                                            .withOpacity(0.15),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10.r),
                                            bottomLeft: Radius.circular(10.r))),
                                    child: Center(
                                      child: Icon(
                                        IconlyLight.calendar,
                                        color: ColorPellets.orange,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Court Booking"),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Row(
                                        children: [
                                          Text("View"),
                                          Icon(
                                            IconlyLight.arrow_right_2,
                                            size: 12.sp,
                                            color: ColorPellets.orange,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Booking History",
                    style: GoogleFonts.poppins(
                        fontSize: 12.sp, fontWeight: FontWeight.w500),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => BookingHistory()));
                    },
                    child: Text(
                      "View All",
                      style: GoogleFonts.poppins(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                          color: ColorPellets.orange),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              // Center(
              //   child: Text("No Records Found"),
              // )
              Consumer<SportsBookingProvider>(builder: (context, booking, _) {
                return booking.bookingHistory != null
                    ? ListView.separated(
                        separatorBuilder: (context, ind) {
                          return SizedBox(
                            height: 12.sp,
                          );
                        },
                        shrinkWrap: true,
                        itemCount: booking.bookingHistory["data"].length > 3
                            ? 3
                            : booking.bookingHistory["data"].length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          var data = booking.bookingHistory["data"][index];
                          return Container(
                            width: getWidth(context),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(
                                    color:
                                        ColorPellets.orange.withOpacity(0.15))),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 10.h),
                            child: Row(
                              children: [
                                Container(
                                  height: 40.h,
                                  width: 50.w,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(100.r),
                                      color: ColorPellets.orange
                                          .withOpacity(0.15)),
                                  child: Center(
                                    child: Image.asset(
                                      "assets/images/sports_icon.png",
                                      width: 25.w,
                                      color: ColorPellets.orange,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data["activity"],
                                        style: GoogleFonts.poppins(
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        "Court Name: ${data["court_name"]}",
                                        style: GoogleFonts.poppins(
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        "Booking Time: ${data["booking_date"].toString().split("T")[0]}",
                                        style: GoogleFonts.poppins(
                                            fontSize: 11.sp),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        })
                    : Center(
                        child: Text("No Bookings Found"),
                      );
              })
            ],
          ),
        ),
      ),
    );
  }
}
