import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chargerrr/core/utils/app_constants.dart';
import 'package:chargerrr/domain/entities/charging_station.dart';
import 'package:chargerrr/domain/usecases/station/get_station_details_usecase.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class StationDetailsController extends GetxController {
  final GetStationDetailsUseCase _getStationDetailsUseCase;

  StationDetailsController(this._getStationDetailsUseCase);

  final station = Rxn<ChargingStation>();
  final isLoading = true.obs;
  final errorMessage = RxnString(null);
  final mapController = Rxn<GoogleMapController>();
  final markers = <Marker>{}.obs;

  @override
  void onInit() {
    super.onInit();
    final stationId = Get.arguments as String;
    loadStationDetails(stationId);
  }

  @override
  void onClose() {
    mapController.value?.dispose();
    super.onClose();
  }

  Future<void> loadStationDetails(String stationId) async {
    isLoading.value = true;
    errorMessage.value = null;

    try {
      final result = await _getStationDetailsUseCase(stationId);
      station.value = result;
      _updateMapMarkers();
    } catch (e) {
      errorMessage.value = 'Failed to load station details: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }

  void _updateMapMarkers() {
    if (station.value == null) return;

    final stationData = station.value!;

    markers.clear();
    markers.add(
      Marker(
        markerId: MarkerId(stationData.id ?? ''),
        position: LatLng(stationData.latitude, stationData.longitude),
        infoWindow: InfoWindow(title: stationData.name),
      ),
    );

    // Center the map on the station location
    final cameraPosition = CameraPosition(
      target: LatLng(stationData.latitude, stationData.longitude),
      zoom: AppConstants.defaultZoom,
    );

    mapController.value?.animateCamera(
      CameraUpdate.newCameraPosition(cameraPosition),
    );
  }

  void onMapCreated(GoogleMapController controller) {
    mapController.value = controller;
    if (station.value != null) {
      _updateMapMarkers();
    }
  }

  void openMapsNavigation() {
    if (station.value == null) return;

    final lat = station.value!.latitude;
    final lng = station.value!.longitude;
    final name = Uri.encodeComponent(station.value!.name);

    final url =
        'https://www.google.com/maps/dir/?api=1&destination=$lat,$lng&destination_place_id=$name';
    // Launch URL using url_launcher package
    // This would typically use url_launcher package, but we'll leave it as a TODO
    // for simplicity in this implementation
    debugPrint('Navigation URL: $url');
  }
}
