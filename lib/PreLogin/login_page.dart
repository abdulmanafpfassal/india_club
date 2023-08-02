import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
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
              child: Container(
                  height: 100.w,
                  child: Image.asset("assets/images/Indian-Club.png")),
            ),
            SizedBox(
              height: 100.h,
            ),
            Text(
              "Welcome To India Club",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            TextField(
              decoration: InputDecoration(
                label: Text(
                  "Member ID",
                  style: GoogleFonts.poppins(
                    fontSize: 11.sp,
                  ),
                ),
              ),
            ),
            TextField(
              decoration: InputDecoration(
                  label: Text(
                "Password",
                style: GoogleFonts.poppins(fontSize: 11.sp),
              )),
            ),
            SizedBox(
              height: 10.h,
            ),
            CustomButton(
                button_text: "Login",
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => HomePage()),
                      (route) => false);
                }),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "Forgot Password?",
              style: GoogleFonts.poppins(
                  fontSize: 11.sp,
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}
