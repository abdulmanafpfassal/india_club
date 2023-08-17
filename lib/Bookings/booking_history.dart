import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:india_club/Src/Provider/sports_provider.dart';
import 'package:provider/provider.dart';

import '../Helpers/colors.dart';
import '../Helpers/utils.dart';
import '../Notification/notification_page.dart';

class BookingHistory extends StatefulWidget {
  const BookingHistory({super.key});

  @override
  State<BookingHistory> createState() => _BookingHistoryState();
}

class _BookingHistoryState extends State<BookingHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Booking History",
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
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => NotificationPage()));
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
              showDialog(
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
      body:  RefreshIndicator(
        color: ColorPellets.orange,
        onRefresh: () async {
          getContext.navigatorKey.currentContext!.read<SportsBookingProvider>().setBookingHistory();
        },
        child: Container(
          margin: EdgeInsets.all(10.0),
          child: Consumer<SportsBookingProvider>(
            builder: (context, booking, _) {
              return booking.bookingHistory != null || booking.bookingHistory["data"] != [] ? ListView.separated(
                  separatorBuilder: (context, ind) {
                    return SizedBox(
                      height: 12.sp,
                    );
                  },
                  shrinkWrap: true,
                  itemCount: booking.bookingHistory["data"].length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    var data = booking.bookingHistory["data"][index];
                    return Container(
                      width: getWidth(context),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                              color: ColorPellets.orange.withOpacity(0.15))),
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                      child: Row(
                        children: [
                          Container(
                            height: 40.h,
                            width: 50.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100.r),
                                color: ColorPellets.orange.withOpacity(0.15)),
                            child: Center(
                              child: Image.asset(
                                "assets/images/sports_icon.png",
                                width: 25.w,
                                color: ColorPellets.orange,
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w
                            ,),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(data["activity"], style: GoogleFonts.poppins(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w500
                                ),),
                                Text("Court Name: ${data["court_name"]}", style: GoogleFonts.poppins(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w500
                                ),),
                                Text(
                                  "Booking Reference No: ${data["name"].toString().split("T")[0]}",
                                  style: GoogleFonts.poppins(
                                      fontSize: 11.sp),
                                ),
                                Text(
                                  "Slot: ${data["slot_name"].toString().split("T")[0]}",
                                  style: GoogleFonts.poppins(
                                      fontSize: 11.sp),
                                ),
                                Text("Booking Time: ${data["booking_date"].toString().split("T")[0]}", style: GoogleFonts.poppins(
                                    fontSize: 11.sp
                                ),),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }): Center(
                child: Text("No Bookings Found"),
              );
            }
          ),
        ),
      ),
    );
  }
}
