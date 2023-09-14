import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:india_club/Src/Repository/home_repo.dart';

class HomeProvider with ChangeNotifier {
  HomeRepo _homeRepo = HomeRepo();

  dynamic banner_images;

  setBannerImage() async {
    banner_images = await _homeRepo.getBannerImages();
    log("the banner images are " + banner_images.toString());
  }
}