import 'package:get/get.dart';
import 'package:chargerrr/domain/usecases/auth/register_usecase.dart';
import 'package:chargerrr/presentation/screens/auth/register/register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(
      () => RegisterController(Get.find<RegisterUseCase>()),
    );
  }
}