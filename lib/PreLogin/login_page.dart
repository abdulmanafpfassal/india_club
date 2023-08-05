import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:india_club/Helpers/colors.dart';
import 'package:india_club/Helpers/utils.dart';
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
      body: Stack(
        children: [
          Container(
            height: getHeight(context) / 2.4,
            width: getWidth(context),
            decoration: BoxDecoration(
                color: Colors.black,
                image: DecorationImage(
                  image: AssetImage("assets/images/banner_logo.jpg"),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.3), BlendMode.dstATop),
                )),
            child: Center(
              child: Image.asset(
                "assets/images/Indian-Club.png",
                height: 80.w,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: getHeight(context) / 1.6,
              width: getWidth(context),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.white, Colors.white,Colors.white,Colors.white, Color(0xFFFDE7CA),Color(0xFFFBCB8D),Color(0xFFFBCB8D), Color(0xFFFBCB8D),  Color(0xFFFBCB8D), Color(0xFFFBCB8D)],

                  ),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.r),
                      topRight: Radius.circular(30.r)),
                  image: DecorationImage(
                      image: AssetImage("assets/images/baseimage.png"),
                      alignment: Alignment.bottomLeft)),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      "Your Member ID",
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
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "Password",
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
                          hintText: "min 8 character",
                          hintStyle: GoogleFonts.poppins(
                              color:  Colors.grey.withOpacity(0.3), fontSize: 11.sp),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Forgot Password?",
                        style: GoogleFonts.poppins(
                            fontSize: 10.sp,
                            color:  ColorPellets.orange,
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
                      },
                      isEnabled: true,
                    ),
                    Spacer(),
                    // Container(
                    //   height: 10.h,
                    //   margin: EdgeInsets.all(20.0),
                    //   child: Center(
                    //       child: Text(
                    //     "By Clicking, I accept the Terms & Conditions and Privacy Policy",
                    //     style: GoogleFonts.poppins(fontSize: 10.sp),
                    //   )),
                    // )
                    Container(
                      height: 10.h,
                      margin: EdgeInsets.all(20.0),
                      child: RichText(
                        text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'By Clicking, I accept the ',
                                style: TextStyle(color: Colors.black, fontSize: 10.sp),
                              ),
                              TextSpan(
                                  text: ' Terms & Conditions',
                                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 10.sp),

                              ),
                              TextSpan(
                                text: ' and',
                                style: TextStyle(color: Colors.black,fontSize: 10.sp),
                              ),
                              TextSpan(
                                text: ' Privacy Policy',
                                style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 10.sp),

                              ),
                            ]
                        )
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
    //   Scaffold(
    //   backgroundColor: Colors.white,
    //   body: Container(
    //     margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
    //     child: Column(
    //       children: [
    //         Center(
    //           child: Column(
    //             children: [
    //               Container(
    //                   height: 80.w,
    //                   child: Image.asset("assets/images/Indian-Club.png")),
    //               Text(
    //                 "Welcome To India Club",
    //                 style: GoogleFonts.poppins(
    //                   fontWeight: FontWeight.w500,
    //                   fontSize: 12.sp,
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //         SizedBox(
    //           height: 100.h,
    //         ),
    //         SizedBox(
    //           height: 10.h,
    //         ),
    //         Text("Your Member ID", style: GoogleFonts.poppins(
    //           fontSize: 12.sp,
    //         ),),
    //         SizedBox(height: 6.h,),
    //         Container(
    //           padding: EdgeInsets.symmetric(horizontal: 10.w),
    //           decoration: BoxDecoration(
    //             border: Border.all(color: Colors.grey),
    //             borderRadius: BorderRadius.circular(40.r)
    //           ),
    //           child: TextField(
    //             decoration: InputDecoration(
    //               border: InputBorder.none,
    //               errorBorder: InputBorder.none,
    //               focusedBorder: InputBorder.none,
    //               enabledBorder: InputBorder.none,
    //               hintText: "737778",
    //               hintStyle: GoogleFonts.poppins(
    //                 color: Colors.grey,
    //                 fontSize: 11.sp
    //               ),
    //             ),
    //           ),
    //         ),
    //         SizedBox(height: 10.h,),
    //         Text("Password", style: GoogleFonts.poppins(
    //           fontSize: 12.sp,
    //         ),),
    //         SizedBox(height: 6.h,),
    //         Container(
    //           padding: EdgeInsets.symmetric(horizontal: 10.w),
    //           decoration: BoxDecoration(
    //               border: Border.all(color: Colors.grey),
    //               borderRadius: BorderRadius.circular(40.r)
    //           ),
    //           child: TextField(
    //             decoration: InputDecoration(
    //               border: InputBorder.none,
    //               errorBorder: InputBorder.none,
    //               focusedBorder: InputBorder.none,
    //               enabledBorder: InputBorder.none,
    //               hintText: "min 8 character",
    //               hintStyle: GoogleFonts.poppins(
    //                   color: Colors.grey,
    //                   fontSize: 11.sp
    //               ),
    //             ),
    //           ),
    //         ),
    //         SizedBox(height: 5.h,),
    //         Align(
    //           alignment: Alignment.centerRight,
    //           child: Text(
    //             "Forgot Password?",
    //             style: GoogleFonts.poppins(
    //                 fontSize: 10.sp,
    //                 color: ColorPellets.orange.withOpacity(0.5),
    //                 fontWeight: FontWeight.w500),
    //           ),
    //         ),
    //         SizedBox(
    //           height: 10.h,
    //         ),
    //         CustomButton(
    //             button_text: "Continue",
    //             onTap: () {
    //               Navigator.of(context).pushAndRemoveUntil(
    //                   MaterialPageRoute(builder: (context) => HomePage()),
    //                   (route) => false);
    //             }, isEnabled: true,),
    //       ],
    //     ),
    //   ),
    //   bottomNavigationBar: Container(
    //     height: 20.h,
    //     child: Center(
    //       child: Text(""),
    //     ),
    //   ),
    // );
  }
}
