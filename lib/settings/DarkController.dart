import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DarkController extends GetxController {
  var isDark = false;

  void changeTheme(state) {
    if (state == true) {
      Get.changeTheme(ThemeData.dark());
    } else {
      Get.changeTheme(ThemeData.light());
    }
  }
}
