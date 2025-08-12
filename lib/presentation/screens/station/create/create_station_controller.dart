import 'package:chargerrr/domain/entities/charging_station.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:chargerrr/core/utils/app_constants.dart';
import 'package:chargerrr/domain/usecases/station/create_station_usecase.dart';

class CreateStationController extends GetxController {
  final CreateStationUseCase _createStationUseCase;

  CreateStationController(this._createStationUseCase);

  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final totalPointsController = TextEditingController();
  final availablePointsController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final selectedAmenities = <String>[].obs;
  final availableAmenities = [
    'Restrooms',
    'Food',
    'Shopping',
    'WiFi',
    'Parking',
    'Lounge',
    '24/7 Access',
    'Fast Charging',
  ];

  final isLoading = false.obs;
  final errorMessage = RxnString(null);
  final selectedLocation = Rxn<LatLng>();
  final mapController = Rxn<GoogleMapController>();
  final markers = <Marker>{}.obs;

  @override
  void onInit() {
    super.onInit();
    // Set default location if none selected
    selectedLocation.value = const LatLng(
      AppConstants.defaultLatitude,
      AppConstants.defaultLongitude,
    );
    _updateMapMarkers();
  }

  @override
  void onClose() {
    nameController.dispose();
    addressController.dispose();
    totalPointsController.dispose();
    availablePointsController.dispose();
    mapController.value?.dispose();
    super.onClose();
  }

  void onMapCreated(GoogleMapController controller) {
    mapController.value = controller;
    _updateMapMarkers();
  }

  void onMapTap(LatLng position) {
    selectedLocation.value = position;
    _updateMapMarkers();
  }

  void _updateMapMarkers() {
    if (selectedLocation.value == null) return;

    markers.clear();
    markers.add(
      Marker(
        markerId: const MarkerId('selected_location'),
        position: selectedLocation.value!,
        infoWindow: const InfoWindow(title: 'Selected Location'),
      ),
    );
  }

  void toggleAmenity(String amenity) {
    if (selectedAmenities.contains(amenity)) {
      selectedAmenities.remove(amenity);
    } else {
      selectedAmenities.add(amenity);
    }
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    return null;
  }

  String? validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Address is required';
    }
    return null;
  }

  String? validateTotalPoints(String? value) {
    if (value == null || value.isEmpty) {
      return 'Total charging points is required';
    }
    if (int.tryParse(value) == null || int.parse(value) <= 0) {
      return 'Please enter a valid number';
    }
    return null;
  }

  String? validateAvailablePoints(String? value) {
    if (value == null || value.isEmpty) {
      return 'Available charging points is required';
    }
    if (int.tryParse(value) == null || int.parse(value) < 0) {
      return 'Please enter a valid number';
    }

    final total = int.tryParse(totalPointsController.text) ?? 0;
    final available = int.tryParse(value) ?? 0;

    if (available > total) {
      return 'Available points cannot exceed total points';
    }

    return null;
  }

  String? validateLocation() {
    if (selectedLocation.value == null) {
      return 'Please select a location on the map';
    }
    return null;
  }

  Future<void> createStation() async {
    if (!formKey.currentState!.validate()) {
      final locationError = validateLocation();
      if (locationError != null) {
        Get.snackbar(
          'Error',
          locationError,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.shade100,
          colorText: Colors.red.shade800,
        );
      }
      return;
    }

    if (selectedLocation.value == null) {
      Get.snackbar(
        'Error',
        'Please select a location on the map',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade800,
      );
      return;
    }

    errorMessage.value = null;
    isLoading.value = true;

    try {
      // await _createStationUseCase(
      //   ChargingStation(
      //     name: nameController.text,
      //     address: addressController.text,
      //     latitude: selectedLocation.value!.latitude,
      //     longitude: selectedLocation.value!.longitude,
      //     totalPoints: int.parse(totalPointsController.text),
      //     availablePoints: int.parse(availablePointsController.text),
      //     amenities: selectedAmenities,
      //   )
      // );
      await _createStationUseCase(
        ChargingStation(
          id: null,
          name: nameController.text,
          address: addressController.text,
          latitude: selectedLocation.value!.latitude,
          longitude: selectedLocation.value!.longitude,
          totalPoints: int.parse(totalPointsController.text),
          availablePoints: int.parse(availablePointsController.text),
          amenities: selectedAmenities,
        ),
      );
      Get.back(result: true);
      Get.snackbar(
        'Success',
        'Charging station created successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.shade100,
        colorText: Colors.green.shade800,
      );
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar(
        'Error',
        'Failed to create charging station: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade800,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
