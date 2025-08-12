import 'package:get/get.dart';
import 'package:chargerrr/domain/usecases/station/get_station_details_usecase.dart';
import 'package:chargerrr/presentation/screens/station/details/station_details_controller.dart';

class StationDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StationDetailsController>(
      () => StationDetailsController(Get.find<GetStationDetailsUseCase>()),
    );
  }
}