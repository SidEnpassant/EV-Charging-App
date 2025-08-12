import 'package:get/get.dart';
import 'package:chargerrr/core/routes/app_pages.dart';
import 'package:chargerrr/domain/usecases/auth/get_current_user_usecase.dart';

class SplashController extends GetxController {
  final GetCurrentUserUseCase _getCurrentUserUseCase;

  SplashController(this._getCurrentUserUseCase);

  @override
  void onInit() {
    super.onInit();
    _checkUserSession();
  }

  Future<void> _checkUserSession() async {
    await Future.delayed(const Duration(seconds: 2)); // Splash screen delay
    
    try {
      final user = await _getCurrentUserUseCase();
      
      if (user != null) {
        Get.offAllNamed(Routes.home);
      } else {
        Get.offAllNamed(Routes.login);
      }
    } catch (e) {
      Get.offAllNamed(Routes.login);
    }
  }
}