import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:india_club/Helpers/colors.dart';

import '../Helpers/utils.dart';

class CustomButton extends StatefulWidget {
  String button_text;
  Function onTap;
  bool isEnabled;
  CustomButton({Key? key, required this.button_text, required this.onTap, required this.isEnabled})
      : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onTap();
      },
      child: Container(
        width: getWidth(context),
        height: 35.h,
        decoration: BoxDecoration(
            color: widget.isEnabled ? ColorPellets.orange : Colors.grey.withOpacity(0.3),
            borderRadius: BorderRadius.circular(40.r)),
        child: Center(
          child: Text(
            widget.button_text,
            style: GoogleFonts.poppins(
                color: widget.isEnabled ? Colors.white : Colors.grey, fontWeight: FontWeight.w500, fontSize: 11.sp),
          ),
        ),
      ),
    );
  }
}
