import 'package:flutter/material.dart';

class NotificationProvider with ChangeNotifier {
  List notifications = [];

  setNotification(String title, String desc) {
    notifications.add({
      "title": title,
      "desc": desc
    });
    notifyListeners();
  }

  clearNotification(){
    if(notifications.isNotEmpty){
      notifications.clear();
    }
  }
}