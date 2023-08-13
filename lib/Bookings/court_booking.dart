import 'dart:developer';

import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:india_club/Bookings/booking_time.dart';
import 'package:india_club/Notification/notification_page.dart';
import 'package:india_club/Src/Provider/sports_provider.dart';
import 'package:india_club/Widget/custom_button.dart';
import 'package:intl/intl.dart';
import 'package:m_toast/m_toast.dart';
import 'package:provider/provider.dart';

import '../Helpers/colors.dart';
import '../Helpers/utils.dart';

class CourtBooking extends StatefulWidget {
  const CourtBooking({super.key});

  @override
  State<CourtBooking> createState() => _CourtBookingState();
}

class _CourtBookingState extends State<CourtBooking> {
  String? selectedSport;
  String? selectedTime;
  DateTime selectedDate = DateTime.now();
  int index1 = -1;
  DatePickerController dateController = DatePickerController();

  String formattedDate = DateFormat('dd MMM yyyy').format(DateTime.now());

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      _updateSelectedDate(pickedDate);
    }
  }

  void _updateSelectedDate(DateTime newDate) {
    setState(() {
      DateTime now = DateTime.now();
      newDate = DateTime(
        newDate.year,
        newDate.month,
        newDate.day,
        now.hour,
        now.minute,
        now.second,
        now.millisecond,
        now.microsecond,
      );
      selectedDate = newDate;
      formattedDate = DateFormat('dd MMM yyyy').format(newDate);
      dateController.animateToDate(selectedDate);
      Future.delayed(Duration(seconds: 0), () async {
        await getContext.navigatorKey.currentContext!
            .read<SportsBookingProvider>()
            .setDate(DateFormat('yyyy-MM-dd').format(selectedDate));
        getContext.navigatorKey.currentContext!
            .read<SportsBookingProvider>()
            .setCourtList();
      });
    });
    getContext.navigatorKey.currentContext!
        .read<SportsBookingProvider>()
        .setDate(DateFormat('yyyy-MM-dd').format(selectedDate));
  }

  @override
  void initState() {
    Future.delayed(Duration(seconds: 0), () async {
      getContext.navigatorKey.currentContext!
          .read<SportsBookingProvider>()
          .clearCourtIdAndSlot();
      await getContext.navigatorKey.currentContext!
          .read<SportsBookingProvider>()
          .setDate(DateFormat('yyyy-MM-dd').format(selectedDate));
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.h),
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title: Text(
                "Booking",
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
            Container(
              child: Row(
                children: [
                  Expanded(
                    child: Container(child: buildDatePicker()),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  InkWell(
                    onTap: () {
                      _selectDate(context);
                    },
                    child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 10.h),
                        decoration: BoxDecoration(
                            // border: Border.all(
                            //     color: ColorPellets.orange.withOpacity(0.6)),
                            borderRadius: BorderRadius.circular(10.r)),
                        child: Icon(IconlyLight.calendar)),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Select Court",
                style: GoogleFonts.poppins(
                    color: Colors.black, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10.h,
              ),
              Consumer<SportsBookingProvider>(builder: (context, provider, _) {
                return provider.courtList != null || provider.isLoading != true
                    ? ListView.separated(
                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        separatorBuilder: (ctx, ind) {
                          return SizedBox(
                            height: 10.h,
                          );
                        },
                        itemCount: provider.courtList["data"].length,
                        itemBuilder: (context, index) {
                          return Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Court Name: ${provider.courtList["data"][index]["name"]}",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 10.sp),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        provider.clearSelectedList(provider
                                            .courtList["data"][index]["name"]);
                                      },
                                      child: Text(
                                        "Clear",
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 10.sp,
                                            color: ColorPellets.orange),
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(),
                                provider.courtList["data"][index]
                                ["slot_availability"] != null ? SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  // Scroll horizontally
                                  child: provider.courtList["data"][index]
                                  ["slot_availability"].length > 0 ? Row(
                                    children: provider.courtList["data"][index]
                                            ["slot_availability"]
                                        .asMap()
                                        .entries
                                        .map<Widget>((e) {
                                      final slot = e.value[
                                          "slot"]; // Access "slot" from the value of the MapEntry
                                      return Consumer<SportsBookingProvider>(
                                          builder: (context, time, _) {
                                        return InkWell(
                                          onTap: () {
                                            time.setCourtId(provider
                                                .courtList["data"][index]["id"]);
                                            time.setSlotId(e.value["id"]);
                                            time.setIsSelectedToTrue(
                                                e.value["id"],
                                                provider.courtList["data"]
                                                    [index]["name"]);
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                right: 10.w, top: 10.h),
                                            child: Text(slot.toString(),
                                                style: GoogleFonts.poppins(
                                                    color: e.value["isSelected"]
                                                        ? Colors.green
                                                        : Colors.grey)),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.w,
                                                vertical: 5.h),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(6.r),
                                              border: Border.all(
                                                  color: e.value["isSelected"]
                                                      ? Colors.green
                                                      : Colors.grey),
                                            ),
                                          ),
                                        );
                                      });
                                    }).toList(),
                                  ) : Center(child: Text("No Slots Available"),),
                                ) : SizedBox(),
                                SizedBox(
                                  height: 10.h,
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
              SizedBox(height: 10.h,),
              Consumer<SportsBookingProvider>(builder: (context, user, _) {
                return Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(
                                color: ColorPellets.orange.withOpacity(0.3))),
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                "Select Members",
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      user.incrementMem();
                                    },
                                    child: Container(
                                      width: 30.w,
                                      height: 30.w,
                                      decoration: BoxDecoration(
                                          color: ColorPellets.orange
                                              .withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(100.r)),
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.orange,
                                        size: 14.sp,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 30.w,
                                    height: 30.w,
                                    child: Center(
                                        child: Text(
                                      user.memberNumber.toString(),
                                      style:
                                          GoogleFonts.poppins(fontSize: 14.sp),
                                    )),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      user.decrementMem();
                                    },
                                    child: Container(
                                      width: 30.w,
                                      height: 30.w,
                                      decoration: BoxDecoration(
                                          color: ColorPellets.orange
                                              .withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(100.r)),
                                      child: Icon(
                                        Icons.remove,
                                        color: Colors.orange,
                                        size: 14.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(
                                color: ColorPellets.orange.withOpacity(0.3))),
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                "Select Guest",
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      user.incrementGuest();
                                    },
                                    child: Container(
                                      width: 30.w,
                                      height: 30.w,
                                      decoration: BoxDecoration(
                                          color: ColorPellets.orange
                                              .withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(100.r)),
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.orange,
                                        size: 14.sp,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 30.w,
                                    height: 30.w,
                                    child: Center(
                                        child: Text(
                                      user.guestNumber.toString(),
                                      style:
                                          GoogleFonts.poppins(fontSize: 14.sp),
                                    )),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      user.decrementGuest();
                                    },
                                    child: Container(
                                      width: 30.w,
                                      height: 30.w,
                                      decoration: BoxDecoration(
                                          color: ColorPellets.orange
                                              .withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(100.r)),
                                      child: Icon(
                                        Icons.remove,
                                        color: Colors.orange,
                                        size: 14.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Consumer<SportsBookingProvider>(
        builder: (context, loading, _) {
          return loading.isLoading ? Center(child: CircularProgressIndicator(color: ColorPellets.orange,),) : Container(
            margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: CustomButton(
              button_text: "Book Now",
              onTap: () {
                loading.doCreateBooking();
              },
              isEnabled: true,
            ),
          );
        }
      ),
    );
  }

  _showDialogBox(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10.w,
              vertical: 20.h, // Adjust the vertical padding as needed
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Thank You!",
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "Booking Successful!",
                  style: GoogleFonts.poppins(fontSize: 12.sp),
                ),
                Text(
                  "Booking Number: BKNG20230803",
                  style: GoogleFonts.poppins(fontSize: 12.sp),
                ),
                SizedBox(height: 10.h),
                // Add spacing between the text and other content
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    primary: Colors.teal, // Set the background color to teal
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog box
                  },
                  child: Text('Go Back'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildDatePicker() {
    return DatePicker(
      DateTime.now(),
      controller: dateController,
      initialSelectedDate: selectedDate,
      selectionColor: ColorPellets.orange.withOpacity(0.6),
      selectedTextColor: Colors.white,
      onDateChange: (date) => _updateSelectedDate(date),
    );
  }
}
