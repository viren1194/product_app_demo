import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  bool isDarkMode = false;

  void toggleTheme() {
    isDarkMode = !isDarkMode;
    Get.changeTheme(
      isDarkMode ? ThemeData.dark() : ThemeData.light(),
    );
    update();
  }
}
