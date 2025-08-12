import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chargerrr/core/routes/app_pages.dart';

class MainNavigationController extends GetxController {
  final selectedIndex = 0.obs;
  final pageController = PageController();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void changePage(int index) {
    selectedIndex.value = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void navigateToMaps() {
    changePage(1);
  }

  void navigateToHome() {
    changePage(0);
  }
}
