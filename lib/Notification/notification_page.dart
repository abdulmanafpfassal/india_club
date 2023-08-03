import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:india_club/Helpers/colors.dart';

import '../Helpers/utils.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {

  List notifications = [
    {
      "title": "Booking Confirmation",
      "message": "Congratulations! Your court booking at Sports Arena - Court 3 is confirmed for August 5, 2023, 7:00 PM. See you there!"
    },
    {
      "title": "Booking Reminder",
      "message": "Just a friendly reminder that your court booking at Sports Arena - Court 3 is tomorrow at 7:00 PM. Play hard and have fun!"
    },
    {
      "title": "Booking Cancellation",
      "message": "Your court booking at Sports Arena - Court 2 on August 10, 2023, 6:30 PM has been canceled. A refund has been processed to your account."
    },
    {
      "title": "Court Availability Alert",
      "message": "Great news! A slot just opened up at Sports Arena - Court 1 on August 15, 2023, 8:00 PM. Book now to secure your spot!"
    },
    {
      "title": "Special Offers and Discounts",
      "message": "🎉 Exclusive Offer 🎉 Get 20% off on your next court booking! Use code COURT20. Limited time offer, book now!"
    },
    {
      "title": "Payment Confirmation",
      "message": "Payment successful! You have been charged 20 for your court booking at Sports Arena - Court 4 on August 20, 2023, 9:00 AM."
    },
    {
      "title": "Court Maintenance Notice",
      "message": "Attention! Sports Arena - Court 5 will be closed for maintenance from August 25 to August 27. We apologize for the inconvenience."
    },
    {
      "title": "User Review Reminder",
      "message": "Hi there! How was your recent court experience? Rate and review your session to let others know about your playtime."
    },
    {
      "title": "App Updates and New Features",
      "message": "New Update Available 📲 Discover our latest features, including court availability alerts and improved booking options. Update now!"
    },
    {
      "title": "Personalized Recommendations",
      "message": "Hey [User], based on your past bookings, we recommend Court 2 at Sports Arena for your next game. Check it out!"
    },
    {
      "title": "Nearby Sports Events",
      "message": "📢 Sports Alert 📢 There's a basketball tournament happening nearby on August 30. Join the action or cheer for your favorite team!"
    },
    {
      "title": "Inactivity Reminder",
      "message": "Hey, it's been a while since your last booking. Come back and book a court to enjoy your favorite sport!"
    },
    {
      "title": "Weather Alerts",
      "message": "🌧️ Weather Advisory 🌧️ Due to heavy rain, all outdoor courts will be closed today. Stay dry and see you on the court soon!"
    },
    {
      "title": "Referral Bonuses",
      "message": "Refer a friend and get 10 credit! Share your unique referral code and earn rewards when they book their first court."
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Notification",
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
      body: Container(
          margin: EdgeInsets.all(10.0),
          child: ListView.separated(
            separatorBuilder: (context, ind) {
              return Divider();
            },
            itemCount: notifications.length,
              itemBuilder: (context, index) {
                return Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 50.w,
                        height: 40.h,
                        decoration: BoxDecoration(
                          color: ColorPellets.orange.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(100.r),
                        ),
                        child: Icon(IconlyLight.notification, color: Colors.white,),
                      ),
                      SizedBox(width: 10.w,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(notifications[index]["title"], style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontSize: 13.sp
                            ),),
                            Text(notifications[index]["message"], style: GoogleFonts.poppins(
                              fontSize: 11.sp,
                              color: Colors.grey
                            ),)
                          ],
                        ),
                      ),

                    ],
                  ),
                );
              })
      ),
    );
  }
}
