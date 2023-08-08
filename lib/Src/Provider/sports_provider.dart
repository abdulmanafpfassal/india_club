import 'package:flutter/material.dart';
import 'package:india_club/Src/Repository/sports_repo.dart';

class SportsBookingProvider with ChangeNotifier {
  SportsBookingRepo _bookingRepo = SportsBookingRepo();

  dynamic sportsList;

  setSportsList() async {
    sportsList = await _bookingRepo.getAllSports();
    notifyListeners();
  }

}