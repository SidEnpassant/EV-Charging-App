import 'package:get/get.dart';
import 'package:chargerrr/domain/usecases/station/create_station_usecase.dart';
import 'package:chargerrr/presentation/screens/station/create/create_station_controller.dart';

class CreateStationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateStationController>(
      () => CreateStationController(Get.find<CreateStationUseCase>()),
    );
  }
}