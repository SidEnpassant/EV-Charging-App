import 'package:chargerrr/presentation/screens/station/create/create_station_binding.dart';
import 'package:chargerrr/presentation/screens/station/create/create_station_screen.dart';
import 'package:chargerrr/presentation/screens/station/details/station_details_binding.dart';
import 'package:chargerrr/presentation/screens/station/details/station_details_screen.dart';
import 'package:chargerrr/presentation/screens/maps/maps_binding.dart';
import 'package:chargerrr/presentation/screens/maps/maps_screen.dart';
import 'package:chargerrr/presentation/screens/main/main_navigation_binding.dart';
import 'package:chargerrr/presentation/screens/main/main_navigation_screen.dart';
import 'package:get/get.dart';
import 'package:chargerrr/presentation/screens/auth/login/login_binding.dart';
import 'package:chargerrr/presentation/screens/auth/login/login_screen.dart';
import 'package:chargerrr/presentation/screens/auth/register/register_binding.dart';
import 'package:chargerrr/presentation/screens/auth/register/register_screen.dart';
import 'package:chargerrr/presentation/screens/home/home_binding.dart';
import 'package:chargerrr/presentation/screens/home/home_screen.dart';
import 'package:chargerrr/presentation/screens/splash/splash_binding.dart';
import 'package:chargerrr/presentation/screens/splash/splash_screen.dart';

part 'app_routes.dart';

class AppPages {
  static const initial = Routes.splash;

  static final routes = [
    GetPage(
      name: Routes.splash,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.login,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.register,
      page: () => const RegisterScreen(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: Routes.home,
      page: () => const MainNavigationScreen(),
      binding: MainNavigationBinding(),
    ),
    GetPage(
      name: Routes.stationDetails,
      page: () => const StationDetailsScreen(),
      binding: StationDetailsBinding(),
    ),
    GetPage(
      name: Routes.stationCreation,
      page: () => const CreateStationScreen(),
      binding: CreateStationBinding(),
    ),
    GetPage(
      name: Routes.maps,
      page: () => const MapsScreen(),
      binding: MapsBinding(),
    ),
  ];
}
