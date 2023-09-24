import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:india_club/Src/Provider/authentication_provider.dart';
import 'package:m_toast/m_toast.dart';
import 'package:provider/provider.dart';

import '../Helpers/colors.dart';
import '../Helpers/utils.dart';
import '../Widget/custom_button.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            IconlyLight.arrow_left_2,
            color: Colors.black,
          ),
        ),
        title: Text(
          "Reset Password",
          style: GoogleFonts.poppins(color: Colors.black),
        ),
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
                    border: Border.all(color: Colors.grey.withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(10.r)),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    hintText: "example@mail.com",
                    hintStyle: GoogleFonts.poppins(
                        color: Colors.grey.withOpacity(0.3), fontSize: 11.sp),
                  ),
                ),
              ),
              Spacer(),
              Consumer<AuthenticationProvider>(
                builder: (context, provider, _) {
                  return provider.isLoading ? Center(child: CircularProgressIndicator(color: ColorPellets.orange,),) : CustomButton(
                    button_text: "Submit",
                    onTap: () {
                      if (emailController.text.trim().length > 0 &&
                          emailController.text.trim().contains("@")) {
                        getContext.navigatorKey.currentContext!
                            .read<AuthenticationProvider>()
                            .doResetPassword(emailController.text.trim());
                      }else{
                        Fluttertoast.showToast(
                          msg: "Enter a valid Email",
                          toastLength: Toast.LENGTH_LONG, // You can change this to Toast.LENGTH_LONG if you want a longer duration
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1, // iOS only
                          backgroundColor: Colors.redAccent,
                          textColor: Colors.black,
                          fontSize: 12.0,
                        );
                      }
                    },
                    isEnabled: true,
                  );
                }
              ),
              SizedBox(
                height: 20.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}
