import 'package:get/get.dart';
import 'package:chargerrr/domain/usecases/station/get_stations_usecase.dart';
import 'package:chargerrr/presentation/screens/maps/maps_controller.dart';

class MapsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MapsController>(
      () => MapsController(Get.find<GetStationsUseCase>()),
    );
  }
}