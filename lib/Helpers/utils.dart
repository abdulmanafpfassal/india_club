import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:india_club/PreLogin/login_page.dart';
import 'package:india_club/Src/Provider/authentication_provider.dart';
import 'package:india_club/Widget/custom_button.dart';
import 'package:provider/provider.dart';

getWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

getHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

class getContext {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

String extractSessionId(String rawSessionString) {
  RegExp regExp = RegExp(r'session_id=([a-fA-F0-9]+)');
  Match? match = regExp.firstMatch(rawSessionString);

  if (match != null) {
    return match.group(1)!;
  }

  return "";
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
                  onTap: () {
                    getContext.navigatorKey.currentContext!.read<AuthenticationProvider>().doLogout();
                  },
                  isEnabled: true,
                ),
              ),
              SizedBox(width: 10.w,),
              Expanded(
                child:
                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 35.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
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
