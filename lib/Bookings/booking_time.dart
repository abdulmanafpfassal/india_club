import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:india_club/Helpers/colors.dart';
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
      getContext.navigatorKey.currentContext!
          .read<SportsBookingProvider>()
          .setCourtList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: Consumer<SportsBookingProvider>(builder: (context, provider, _) {
          return provider.courtList != null || provider.isLoading != true
              ? ListView.separated(
                  separatorBuilder: (ctx, ind) {
                    return SizedBox(
                      height: 6.h,
                    );
                  },
                  itemCount: provider.courtList["data"].length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: getWidth(context),
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.black.withOpacity(0.3)),
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.r))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            provider.courtList["data"][index]["name"],
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600, fontSize: 12.sp),
                          ),
                          Divider(),
                          Wrap(
                            children: provider.courtList["data"][index]
                                    ["slot_availability"]
                                .asMap()
                                .entries
                                .map<Widget>((e) {
                              final slot = e.value[
                                  "slot"]; // Access "slot" from the value of the MapEntry
                              return Container(
                                margin: EdgeInsets.only(right: 10.w, top: 10.h),
                                child: Text(slot.toString(),
                                    style: GoogleFonts.poppins(
                                        color: Colors.green)),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 5.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6.r),
                                  border: Border.all(color: Colors.green),
                                ),
                              );
                            }).toList(),
                          )
                        ],
                      ),
                    );
                  },
                )
              : Container(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: ColorPellets.orange,
                    ),
                  ),
                );
        }),
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
