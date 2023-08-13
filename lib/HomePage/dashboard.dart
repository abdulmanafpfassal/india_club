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
  int index1 = -1;

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
          onTap: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          child: Container(
              padding: EdgeInsets.all(15.0),
              child: Image.asset(
                "assets/images/hamburger.png",
              )),
        ),
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<AuthenticationProvider>(builder: (context, name, _) {
              return name.memberDetails != null
                  ? Text(
                      "Hi ${name.memberDetails["data"][0]["name"].toString()}",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 13.sp,
                          color: Colors.black),
                    )
                  : Text(
                      "Hi ",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 13.sp,
                          color: Colors.black),
                    );
            }),
            Text(
              "Welcome Back",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.sp,
                  color: Colors.black),
            )
          ],
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
              showDialog(
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
              // SizedBox(height: 10.h,),
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Text("Hi Manaf", style: GoogleFonts.poppins(
              //       fontWeight: FontWeight.w500,
              //       fontSize: 13.sp
              //     ),),
              //     Text("Welcome Back", style: GoogleFonts.poppins(
              //         fontWeight: FontWeight.bold,
              //         fontSize: 15.sp
              //     ),)
              //   ],
              // ),
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
                  "assets/images/benner-2.jpg"
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
              // SizedBox(
              //   height: 10.h,
              // ),
              // Container(
              //   width: getWidth(context),
              //   padding: EdgeInsets.all(10.0),
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(10.r),
              //     border:
              //         Border.all(color: ColorPellets.orange.withOpacity(0.1)),
              //   ),
              //   child: Column(
              //     children: [
              //       Row(
              //         children: [
              //           ClipRRect(
              //             borderRadius: BorderRadius.circular(200.r),
              //             child: Image.asset(
              //               "assets/images/dummy.jpg",
              //               height: 60.h,
              //             ),
              //           ),
              //           SizedBox(
              //             width: 10.w,
              //           ),
              //           Consumer<AuthenticationProvider>(
              //               builder: (context, details, _) {
              //             return details.memberDetails != null
              //                 ? Column(
              //                     crossAxisAlignment: CrossAxisAlignment.start,
              //                     children: [
              //                       details.memberDetails["data"][0]
              //                                       ["surname"] ==
              //                                   null ||
              //                               details.memberDetails["data"][0]
              //                                       ["surname"] ==
              //                                   ""
              //                           ? Text(
              //                               details.memberDetails["data"][0]
              //                                       ["name"]
              //                                   .toString(),
              //                               style: GoogleFonts.poppins(
              //                                   fontWeight: FontWeight.w500,
              //                                   fontSize: 11.sp,
              //                                   color: Colors.black
              //                                       .withOpacity(0.6)),
              //                             )
              //                           : Text(
              //                               details.memberDetails["data"][0]
              //                                           ["name"]
              //                                       .toString() +
              //                                   " " +
              //                                   details.memberDetails["data"][0]
              //                                           ["surname"]
              //                                       .toString(),
              //                               style: GoogleFonts.poppins(
              //                                   fontWeight: FontWeight.w500,
              //                                   fontSize: 11.sp,
              //                                   color: Colors.black
              //                                       .withOpacity(0.6)),
              //                             ),
              //                       SizedBox(
              //                         height: 3.h,
              //                       ),
              //                       Text(
              //                         "Member ID: ${details.memberDetails["data"][0]["membership_no"].toString()}",
              //                         style: GoogleFonts.poppins(
              //                             fontWeight: FontWeight.w500,
              //                             fontSize: 11.sp,
              //                             color: Colors.black.withOpacity(0.6)),
              //                       ),
              //                     ],
              //                   )
              //                 : Center(
              //                     child: Text(
              //                       "Loading...",
              //                       style: GoogleFonts.poppins(
              //                           color: Colors.grey, fontSize: 10.sp),
              //                     ),
              //                   );
              //           })
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Booking",
                style: GoogleFonts.poppins(
                    fontSize: 12.sp, fontWeight: FontWeight.w500),
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
                    Consumer<SportsBookingProvider>(
                        builder: (context, sports, _) {
                      return sports.sportsList1 != null ||
                              sports.isLoading != true
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: sports.sportsList1["data"]
                                  .asMap()
                                  .entries
                                  .map<Widget>((entry) {
                                int currentIndex = entry.key;
                                dynamic data = entry.value;

                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      index1 = currentIndex;
                                      sports
                                          .setActivityId(data["id"].toString());
                                      sports.setSportsName(data["activity"]);
                                      Future.delayed(Duration(seconds: 0),
                                          () async {
                                        await Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CourtBooking()));
                                        index1 = -1;
                                      });
                                    });
                                  },
                                  child: Container(
                                    // margin:
                                    //     EdgeInsets.only(right: 13.w, top: 10.h),
                                    child: Material(
                                      borderRadius: BorderRadius.circular(10.r),
                                      color: Colors.white,
                                      elevation: 4,
                                      child: Container(
                                        // margin:
                                        //     EdgeInsets.only(right: 13.w, top: 10.h),
                                        height: 100.h,
                                        width: 100.w,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey
                                                      .withOpacity(0.3)),
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Center(
                                              child: Container(
                                                width: currentIndex == 2 ? 40.w : 50.w,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius
                                                        .only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    10.r),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10.r))),
                                                child: Center(
                                                  child: Image.asset(
                                                    data["icon"],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 6.h,
                                            ),
                                            Text(
                                              data["activity"],
                                              // Assuming "name" is the key for the sport's name
                                              style: GoogleFonts.poppins(
                                                  fontSize: 11.sp,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            SizedBox()
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList())
                          : Container(
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: ColorPellets.orange,
                                ),
                              ),
                            );
                    }),
                    SizedBox(height: 10.h,),
                    Consumer<SportsBookingProvider>(
                        builder: (context, sports, _) {
                      return sports.sportsList2 != null ||
                              sports.isLoading != true
                          ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                              children: sports.sportsList2["data"]
                                  .asMap()
                                  .entries
                                  .map<Widget>((entry) {
                              int currentIndex = entry.key;
                              dynamic data = entry.value;

                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    index1 = currentIndex;
                                    sports.setActivityId(data["id"].toString());
                                    sports.setSportsName(data["activity"]);
                                    Future.delayed(Duration(seconds: 0),
                                        () async {
                                      await Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CourtBooking()));
                                      index1 = -1;
                                    });
                                  });
                                },
                                child: Container(
                                  margin:
                                      EdgeInsets.only(right: 20.w, top: 10.h),
                                  child: Material(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: Colors.white,
                                    elevation: 4,
                                    child: Container(
                                      // margin:
                                      //     EdgeInsets.only(right: 13.w, top: 10.h),
                                      height: 100.h,
                                      width: 100.w,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey.withOpacity(0.3)),
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Center(
                                            child: Container(
                                              width: currentIndex == 0 ? 40.w : 50.w,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  10.r),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  10.r))),
                                              child: Center(
                                                child: Image.asset(
                                                  data["icon"],
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 6.h,
                                          ),
                                          Text(
                                            data["activity"],
                                            // Assuming "name" is the key for the sport's name
                                            style: GoogleFonts.poppins(
                                                fontSize: 11.sp,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox()
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList())
                          : Container(
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: ColorPellets.orange,
                                ),
                              ),
                            );
                    })
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
