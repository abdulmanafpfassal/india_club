import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

import '../Helpers/colors.dart';
import '../Helpers/utils.dart';
import '../Widget/custom_button.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(IconlyLight.arrow_left_2,color: Colors.black,),),
        title: Text("Reset Password", style: GoogleFonts.poppins(
          color: Colors.black
        ),),
      ),
      backgroundColor: Colors.white,
      body: Container(
        width: getWidth(context),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Your Email ID",
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                ),
              ),
              SizedBox(
                height: 6.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                decoration: BoxDecoration(
                    border: Border.all(color:  Colors.grey.withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(10.r)),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    hintText: "737778",
                    hintStyle: GoogleFonts.poppins(
                        color:  Colors.grey.withOpacity(0.3), fontSize: 11.sp),
                  ),
                ),
              ),
              Spacer(),
              CustomButton(
                button_text: "Submit",
                onTap: () {
                  Navigator.pop(context);
                },
                isEnabled: true,
              ),
              SizedBox(height: 20.h,)
            ],
          ),
        ),
      ),
    );
  }
}
