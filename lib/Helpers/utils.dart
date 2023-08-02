import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:india_club/PreLogin/login_page.dart';
import 'package:india_club/Widget/custom_button.dart';

getWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

getHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

getHomeAppBar() {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    actions: [
      Icon(
        IconlyLight.notification,
        color: Colors.black,
      ),
      SizedBox(
        width: 20.w,
      ),
      InkWell(
        onTap: () {},
        child: Icon(
          IconlyLight.logout,
          color: Colors.red,
        ),
      ),
      SizedBox(
        width: 10.w,
      ),
    ],
  );
}

getAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(
          IconlyLight.arrow_left_2,
          color: Colors.black,
        )),
    actions: [
      Icon(
        IconlyLight.notification,
        color: Colors.black,
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
  );
}

class LogoutDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Are you sure you want to Logout?"),
          SizedBox(height: 20.h,),
          Row(
            children: [
              Expanded(
                child:
                CustomButton(
                  button_text: "Logout",
                  onTap: (){
                    Navigator.pop(context);
                  },
                ),
              ),
              SizedBox(width: 10.w,),
              Expanded(
                child:
                InkWell(
                  onTap: (){
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
                  },
                  child: Container(
                    height: 35.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.r),
                        border: Border.all(color: Colors.black)
                    ),
                    child: Center(child: Text("Cancel")),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
