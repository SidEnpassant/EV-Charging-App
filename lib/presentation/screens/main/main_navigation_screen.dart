import 'package:chargerrr/presentation/screens/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chargerrr/presentation/screens/home/home_screen.dart';
import 'package:chargerrr/presentation/screens/maps/maps_screen.dart';
import 'package:chargerrr/presentation/screens/main/main_navigation_controller.dart';
import 'package:chargerrr/presentation/widgets/animated_bottom_bar.dart';

class MainNavigationScreen extends GetView<MainNavigationController> {
  const MainNavigationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [HomeScreen(), MapsScreen()],
      ),
      floatingActionButton: Obx(() {
        // Only show FAB on home screen
        return controller.selectedIndex.value == 0
            ? FloatingActionButton(
                onPressed: () =>
                    Get.find<HomeController>().navigateToCreateStation(),
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: const Icon(Icons.add),
              )
            : const SizedBox.shrink();
      }),
      bottomNavigationBar: Obx(
        () => AnimatedBottomBar(
          selectedIndex: controller.selectedIndex.value,
          onItemSelected: controller.changePage,
        ),
      ),
    );
  }
}
