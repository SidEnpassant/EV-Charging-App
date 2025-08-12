import 'package:get/get.dart';
import 'package:chargerrr/presentation/screens/home/home_binding.dart';
import 'package:chargerrr/presentation/screens/maps/maps_binding.dart';
import 'package:chargerrr/presentation/screens/main/main_navigation_controller.dart';

class MainNavigationBinding extends Bindings {
  @override
  void dependencies() {
    // Initialize the main navigation controller
    Get.lazyPut<MainNavigationController>(
      () => MainNavigationController(),
    );
    
    // Initialize the controllers for child screens
    HomeBinding().dependencies();
    MapsBinding().dependencies();
  }
}