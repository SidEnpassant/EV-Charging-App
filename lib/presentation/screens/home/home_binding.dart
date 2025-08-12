import 'package:get/get.dart';
import 'package:chargerrr/domain/usecases/auth/get_current_user_usecase.dart';
import 'package:chargerrr/domain/usecases/auth/logout_usecase.dart';
import 'package:chargerrr/domain/usecases/station/get_stations_usecase.dart';
import 'package:chargerrr/presentation/screens/home/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(
        Get.find<GetStationsUseCase>(),
        Get.find<GetCurrentUserUseCase>(),
        Get.find<LogoutUseCase>(),
      ),
    );
  }
}