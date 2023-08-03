import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:india_club/Helpers/colors.dart';
import 'package:india_club/HomePage/home_page.dart';
import 'package:india_club/Widget/custom_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                      height: 80.w,
                      child: Image.asset("assets/images/Indian-Club.png")),
                  Text(
                    "Welcome To India Club",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 100.h,
            ),
            SizedBox(
              height: 10.h,
            ),
            Text("Your Member ID", style: GoogleFonts.poppins(
              fontSize: 12.sp,
            ),),
            SizedBox(height: 6.h,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(40.r)
              ),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  hintText: "737778",
                  hintStyle: GoogleFonts.poppins(
                    color: Colors.grey,
                    fontSize: 11.sp
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h,),
            Text("Password", style: GoogleFonts.poppins(
              fontSize: 12.sp,
            ),),
            SizedBox(height: 6.h,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(40.r)
              ),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  hintText: "min 8 character",
                  hintStyle: GoogleFonts.poppins(
                      color: Colors.grey,
                      fontSize: 11.sp
                  ),
                ),
              ),
            ),
            SizedBox(height: 5.h,),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Forgot Password?",
                style: GoogleFonts.poppins(
                    fontSize: 10.sp,
                    color: ColorPellets.orange.withOpacity(0.5),
                    fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            CustomButton(
                button_text: "Continue",
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => HomePage()),
                      (route) => false);
                }, isEnabled: true,),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 20.h,
        child: Center(
          child: Text(""),
        ),
      ),
    );
  }
}
