import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:chargerrr/domain/entities/charging_station.dart';
import 'package:chargerrr/domain/usecases/station/get_stations_usecase.dart';

class MapsController extends GetxController {
  final GetStationsUseCase _getStationsUseCase;

  MapsController(this._getStationsUseCase);

  final mapController = Rxn<GoogleMapController>();
  final markers = <Marker>{}.obs;
  final stations = <ChargingStation>[].obs;
  final isLoading = true.obs;
  final errorMessage = RxnString(null);
  final currentPosition = Rx<LatLng>(const LatLng(0, 0));
  final searchController = TextEditingController();
  final selectedStation = Rxn<ChargingStation>();
  final showInfoWindow = false.obs;
  final infoWindowPosition = Rx<LatLng>(const LatLng(0, 0));

  @override
  void onInit() {
    super.onInit();
    getCurrentLocation();
    loadStations();
  }

  @override
  void onClose() {
    mapController.value?.dispose();
    searchController.dispose();
    super.onClose();
  }

  Future<void> getCurrentLocation() async {
    try {
      final permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        await Geolocator.requestPermission();
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      currentPosition.value = LatLng(position.latitude, position.longitude);

      mapController.value?.animateCamera(
        CameraUpdate.newLatLng(currentPosition.value),
      );
    } catch (e) {
      debugPrint('Error getting current location: $e');
      // Default to a fallback location if we can't get the user's location
      currentPosition.value = const LatLng(37.7749, -122.4194); // San Francisco
    }
  }

  Future<void> loadStations() async {
    isLoading.value = true;
    errorMessage.value = null;

    try {
      final result = await _getStationsUseCase();
      stations.value = result;
      _updateMapMarkers();
    } catch (e) {
      errorMessage.value = 'Failed to load charging stations: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }

  void _updateMapMarkers() {
    markers.clear();

    for (final station in stations) {
      final marker = Marker(
        markerId: MarkerId(station.id ?? ''),
        position: LatLng(station.latitude, station.longitude),
        onTap: () => _showStationInfo(station),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          station.availablePoints > 0 
              ? BitmapDescriptor.hueGreen 
              : BitmapDescriptor.hueRed
        ),
      );

      markers.add(marker);
    }
  }

  void _showStationInfo(ChargingStation station) {
    selectedStation.value = station;
    infoWindowPosition.value = LatLng(station.latitude, station.longitude);
    showInfoWindow.value = true;

    mapController.value?.animateCamera(
      CameraUpdate.newLatLng(infoWindowPosition.value),
    );
  }

  void closeInfoWindow() {
    showInfoWindow.value = false;
  }

  void onMapCreated(GoogleMapController controller) {
    mapController.value = controller;
    if (stations.isNotEmpty) {
      _updateMapMarkers();
    }
  }

  Future<void> searchLocation(String query) async {
    if (query.isEmpty) return;

    // This would typically use a geocoding service
    // For simplicity, we'll just search through station addresses
    final matchingStations = stations.where(
      (station) => station.address.toLowerCase().contains(query.toLowerCase()) ||
          station.name.toLowerCase().contains(query.toLowerCase()),
    ).toList();

    if (matchingStations.isNotEmpty) {
      final station = matchingStations.first;
      final position = LatLng(station.latitude, station.longitude);

      mapController.value?.animateCamera(
        CameraUpdate.newLatLngZoom(position, 15),
      );

      _showStationInfo(station);
    }
  }

  void navigateToStation(ChargingStation station) async {
    final lat = station.latitude;
    final lng = station.longitude;
    final name = Uri.encodeComponent(station.name);

    final url = 'https://www.google.com/maps/dir/?api=1&destination=$lat,$lng&destination_place_id=$name';
    
    try {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Could not open maps application',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void centerOnUserLocation() {
    getCurrentLocation();
  }
}