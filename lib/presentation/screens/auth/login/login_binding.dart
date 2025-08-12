import 'package:get/get.dart';
import 'package:chargerrr/domain/usecases/auth/login_usecase.dart';
import 'package:chargerrr/presentation/screens/auth/login/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController(Get.find<LoginUseCase>()));
  }
}