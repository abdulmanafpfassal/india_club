import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:india_club/Helpers/utils.dart';
import 'package:provider/provider.dart';

import '../Helpers/colors.dart';
import '../Src/Provider/sports_provider.dart';
import '../Widget/base64_convertion.dart';
import 'court_booking.dart';

class SportsList extends StatefulWidget {
  const SportsList({super.key});

  @override
  State<SportsList> createState() => _SportsListState();
}

class _SportsListState extends State<SportsList> {
  int index1 = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Consumer<SportsBookingProvider>(
          builder: (context, sports, _) {
            return sports.sportsList != null || sports.isLoading != true
                ? Wrap(
                children: sports.sportsList["data"]
                    .asMap()
                    .entries
                    .map<Widget>((entry) {
                  int currentIndex = entry.key;
                  dynamic data = entry.value;

                  return InkWell(
                    onTap: ()  {
                      setState(() {
                        index1 = currentIndex;
                        sports.setActivityId(data["id"].toString());
                        Future.delayed(Duration(seconds: 0), () async {
                         await Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CourtBooking()));
                         Navigator.pop(context);
                        });
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 10.w, top: 10.h),
                      height: 70.h,
                      width: 70.w,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: index1 == currentIndex
                                  ? ColorPellets.orange
                                  : Colors.grey.withOpacity(0.3)),
                          borderRadius: BorderRadius.circular(10.r)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Container(
                              width: 70,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10.r),
                                      bottomLeft:
                                          Radius.circular(10.r))),
                              child: Center(
                                child:  Base64ImageWidget(
                                  base64Url: data["icon"],
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
                  );
                }).toList())
                : Container(child: Center(child: CircularProgressIndicator(color: ColorPellets.orange,),),);
          }),
    );
  }
}
