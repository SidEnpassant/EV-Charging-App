import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:chargerrr/core/theme/app_theme.dart';
import 'package:chargerrr/core/utils/app_constants.dart';
import 'package:chargerrr/presentation/screens/station/details/station_details_controller.dart';
import 'package:chargerrr/presentation/widgets/custom_button.dart';

class StationDetailsScreen extends GetView<StationDetailsController> {
  const StationDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.value != null) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    controller.errorMessage.value!,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red.shade800),
                  ),
                  const SizedBox(height: 16),
                  CustomButton(
                    text: 'Go Back',
                    onPressed: () => Get.back(),
                    // buttonType: ButtonType.outlined,
                  ),
                ],
              ),
            ),
          );
        }

        if (controller.station.value == null) {
          return const Center(child: Text('Station not found'));
        }

        final station = controller.station.value!;
        final availabilityColor = station.availablePoints > 0
            ? Colors.green.shade700
            : Colors.red.shade700;

        return CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 250,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(background: _buildMap()),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child:
                              Text(
                                station.name,
                                style: Get.textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ).animate().fadeIn().slideX(
                                begin: -0.1,
                                end: 0,
                                duration: 400.ms,
                              ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: availabilityColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: availabilityColor.withOpacity(0.5),
                            ),
                          ),
                          child: Text(
                            '${station.availablePoints}/${station.totalPoints} Available',
                            style: TextStyle(
                              color: availabilityColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ).animate().fadeIn(delay: 200.ms),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            station.address,
                            style: Get.textTheme.bodyLarge?.copyWith(
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ),
                      ],
                    ).animate().fadeIn(delay: 300.ms),
                    const SizedBox(height: 24),
                    Text(
                      'Amenities',
                      style: Get.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ).animate().fadeIn(delay: 400.ms),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: station.amenities.map((amenity) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            amenity,
                            style: TextStyle(color: Colors.grey.shade800),
                          ),
                        ).animate().fadeIn(
                          delay: Duration(
                            milliseconds:
                                500 + station.amenities.indexOf(amenity) * 100,
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24),
                    CustomButton(
                          text: 'Navigate to Station',
                          onPressed: controller.openMapsNavigation,
                          icon: Icons.directions,
                        )
                        .animate()
                        .fadeIn(delay: 600.ms)
                        .slideY(
                          begin: 0.1,
                          end: 0,
                          delay: 600.ms,
                          duration: 400.ms,
                        ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildMap() {
    return Obx(() {
      final station = controller.station.value;
      if (station == null) {
        return Container(color: Colors.grey.shade200);
      }

      return GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(station.latitude, station.longitude),
          zoom: AppConstants.defaultZoom,
        ),
        markers: controller.markers,
        onMapCreated: controller.onMapCreated,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: false,
        mapToolbarEnabled: false,
      );
    });
  }
}
