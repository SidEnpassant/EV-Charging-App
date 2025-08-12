import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:chargerrr/core/utils/app_constants.dart';
import 'package:chargerrr/presentation/screens/maps/maps_controller.dart';
import 'package:chargerrr/presentation/widgets/map_info_window.dart';

class MapsScreen extends GetView<MapsController> {
  const MapsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildMap(),
          _buildSearchBar(),
          _buildInfoWindow(),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildMap() {
    return Obx(() {
      return GoogleMap(
        initialCameraPosition: CameraPosition(
          target: controller.currentPosition.value,
          zoom: AppConstants.defaultZoom,
        ),
        markers: controller.markers,
        onMapCreated: controller.onMapCreated,
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        mapToolbarEnabled: false,
        onTap: (_) => controller.closeInfoWindow(),
        onCameraMove: (_) {
          // Close info window when camera moves
          if (controller.showInfoWindow.value) {
            controller.closeInfoWindow();
          }
        },
      );
    });
  }

  Widget _buildSearchBar() {
    return Positioned(
      top: 50,
      left: 20,
      right: 20,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: TextField(
          controller: controller.searchController,
          decoration: InputDecoration(
            hintText: 'Search location',
            prefixIcon: const Icon(Icons.search),
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                controller.searchController.clear();
                FocusScope.of(Get.context!).unfocus();
              },
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
          onSubmitted: (value) => controller.searchLocation(value),
        ),
      ),
    );
  }

  Widget _buildInfoWindow() {
    return Obx(() {
      if (!controller.showInfoWindow.value ||
          controller.selectedStation.value == null) {
        return const SizedBox.shrink();
      }

      return Positioned(
        bottom: 120,
        left: 20,
        right: 20,
        child: MapInfoWindow(
          station: controller.selectedStation.value!,
          onNavigate: () =>
              controller.navigateToStation(controller.selectedStation.value!),
          onClose: controller.closeInfoWindow,
        ),
      );
    });
  }

  Widget _buildActionButtons() {
    return Positioned(
      bottom: 30,
      right: 20,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: 'location',
            mini: true,
            onPressed: controller.centerOnUserLocation,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black87,
            child: const Icon(Icons.my_location),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            heroTag: 'refresh',
            mini: true,
            onPressed: controller.loadStations,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black87,
            child: const Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}
