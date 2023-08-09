import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:india_club/Src/Provider/sports_provider.dart';

import '../Helpers/utils.dart';
import '../Notification/notification_page.dart';
import '../Widget/custom_button.dart';
import 'package:provider/provider.dart';

class BookingTime extends StatefulWidget {
  const BookingTime({super.key});

  @override
  State<BookingTime> createState() => _BookingTimeState();
}

class _BookingTimeState extends State<BookingTime> {

  @override
  void initState() {
    Future.delayed(Duration(seconds: 0), () {
      getContext.navigatorKey.currentContext!.read<SportsBookingProvider>().setCourtList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Availability",
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
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: ListView.separated(
          separatorBuilder: (ctx, ind){
            return SizedBox(height: 6.h,);
          },
          itemCount: 5,
          itemBuilder: (context, index){
            return Container(
              width: getWidth(context),
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black.withOpacity(0.3)),
                  borderRadius: BorderRadius.all(Radius.circular(10.r))
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${index+6}:00 AM - ${index+7}:00 AM", style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 12.sp
                  ),),
                  Divider(),
                  Wrap(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 10.w, top: 10.h),
                        child: Text("B001", style: GoogleFonts.poppins(
                            color: Colors.green
                        ),),
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.r),
                            border: Border.all(color: Colors.green)
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 10.w, top: 10.h),
                        child: Text("B002", style: GoogleFonts.poppins(
                            color: Colors.grey
                        ),),
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.r),
                            border: Border.all(color: Colors.grey)
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 10.w, top: 10.h),
                        child: Text("B003", style: GoogleFonts.poppins(
                            color: Colors.green
                        ),),
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.r),
                            border: Border.all(color: Colors.green)
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 10.w, top: 10.h),
                        child: Text("B004", style: GoogleFonts.poppins(
                            color: Colors.grey
                        ),),
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.r),
                            border: Border.all(color: Colors.grey)
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: CustomButton(
          button_text: "Submit",
          onTap: () {
            Navigator.pop(context);
          },
          isEnabled: true,
        ),
      ),
    );
  }
}
