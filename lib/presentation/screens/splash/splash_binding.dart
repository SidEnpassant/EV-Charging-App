import 'package:get/get.dart';
import 'package:chargerrr/domain/usecases/auth/get_current_user_usecase.dart';
import 'package:chargerrr/presentation/screens/splash/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController(Get.find<GetCurrentUserUseCase>()));
  }
}