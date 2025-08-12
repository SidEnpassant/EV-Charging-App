// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:chargerrr/core/utils/app_constants.dart';
// import 'package:chargerrr/presentation/screens/maps/maps_controller.dart';
// import 'package:chargerrr/presentation/widgets/map_info_window.dart';

// class MapsScreen extends GetView<MapsController> {
//   const MapsScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           _buildMap(),
//           _buildSearchBar(),
//           _buildInfoWindow(),
//           _buildActionButtons(),
//         ],
//       ),
//     );
//   }

//   Widget _buildMap() {
//     return Obx(() {
//       return GoogleMap(
//         initialCameraPosition: CameraPosition(
//           target: controller.currentPosition.value,
//           zoom: AppConstants.defaultZoom,
//         ),
//         markers: controller.markers,
//         onMapCreated: controller.onMapCreated,
//         myLocationEnabled: true,
//         myLocationButtonEnabled: false,
//         zoomControlsEnabled: false,
//         mapToolbarEnabled: false,
//         onTap: (_) => controller.closeInfoWindow(),
//         onCameraMove: (_) {
//           // Close info window when camera moves
//           if (controller.showInfoWindow.value) {
//             controller.closeInfoWindow();
//           }
//         },
//       );
//     });
//   }

//   Widget _buildSearchBar() {
//     return Positioned(
//       top: 50,
//       left: 20,
//       right: 20,
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(8),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               blurRadius: 10,
//               offset: const Offset(0, 5),
//             ),
//           ],
//         ),
//         child: TextField(
//           controller: controller.searchController,
//           decoration: InputDecoration(
//             hintText: 'Search location',
//             prefixIcon: const Icon(Icons.search),
//             suffixIcon: IconButton(
//               icon: const Icon(Icons.clear),
//               onPressed: () {
//                 controller.searchController.clear();
//                 FocusScope.of(Get.context!).unfocus();
//               },
//             ),
//             border: InputBorder.none,
//             contentPadding: const EdgeInsets.symmetric(
//               horizontal: 16,
//               vertical: 14,
//             ),
//           ),
//           onSubmitted: (value) => controller.searchLocation(value),
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoWindow() {
//     return Obx(() {
//       if (!controller.showInfoWindow.value ||
//           controller.selectedStation.value == null) {
//         return const SizedBox.shrink();
//       }

//       return Positioned(
//         bottom: 120,
//         left: 20,
//         right: 20,
//         child: MapInfoWindow(
//           station: controller.selectedStation.value!,
//           onNavigate: () =>
//               controller.navigateToStation(controller.selectedStation.value!),
//           onClose: controller.closeInfoWindow,
//         ),
//       );
//     });
//   }

//   Widget _buildActionButtons() {
//     return Positioned(
//       bottom: 30,
//       right: 20,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           FloatingActionButton(
//             heroTag: 'location',
//             mini: true,
//             onPressed: controller.centerOnUserLocation,
//             backgroundColor: Colors.white,
//             foregroundColor: Colors.black87,
//             child: const Icon(Icons.my_location),
//           ),
//           const SizedBox(height: 8),
//           FloatingActionButton(
//             heroTag: 'refresh',
//             mini: true,
//             onPressed: controller.loadStations,
//             backgroundColor: Colors.white,
//             foregroundColor: Colors.black87,
//             child: const Icon(Icons.refresh),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:chargerrr/domain/entities/charging_station.dart';
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
          _buildPersistentInfoWindows(),
          _buildExpandedInfoWindow(),
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
        onTap: (_) => controller.closeExpandedInfo(),
        onCameraMove: controller.onCameraMove,
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

  Widget _buildPersistentInfoWindows() {
    return Obx(() {
      return Stack(
        children: controller.stations.map((station) {
          return _buildPersistentInfoWindow(station);
        }).toList(),
      );
    });
  }

  Widget _buildPersistentInfoWindow(ChargingStation station) {
    return Obx(() {
      if (controller.mapController.value == null) {
        return const SizedBox.shrink();
      }

      // Calculate screen position from lat/lng
      return FutureBuilder<ScreenCoordinate>(
        future: controller.mapController.value!.getScreenCoordinate(
          LatLng(station.latitude, station.longitude),
        ),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const SizedBox.shrink();

          final screenPosition = snapshot.data!;
          final isExpanded = controller.expandedStationId.value == station.id;

          // Don't show persistent info if this station is expanded
          if (isExpanded) return const SizedBox.shrink();

          return Positioned(
            left: screenPosition.x.toDouble() - 40, // Center the widget
            top: screenPosition.y.toDouble() - 60, // Position above marker
            child: GestureDetector(
              // In your _buildPersistentInfoWindow method, change this line:
              onTap: () => controller.toggleStationInfo(station),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: station.availablePoints > 0
                        ? Colors.green.shade300
                        : Colors.red.shade300,
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: station.availablePoints > 0
                            ? Colors.green
                            : Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${station.availablePoints}',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }

  Widget _buildExpandedInfoWindow() {
    return Obx(() {
      if (controller.expandedStationId.value == null ||
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
          onClose: controller.closeExpandedInfo,
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
          // Zoom In Button
          FloatingActionButton(
            heroTag: 'zoomIn',
            mini: true,
            onPressed: controller.zoomIn,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black87,
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 8),
          // Zoom Out Button
          FloatingActionButton(
            heroTag: 'zoomOut',
            mini: true,
            onPressed: controller.zoomOut,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black87,
            child: const Icon(Icons.remove),
          ),
          const SizedBox(height: 8),
          // Current Location Button
          FloatingActionButton(
            heroTag: 'location',
            mini: true,
            onPressed: controller.centerOnUserLocation,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black87,
            child: const Icon(Icons.my_location),
          ),
          const SizedBox(height: 8),
          // Refresh Button
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
