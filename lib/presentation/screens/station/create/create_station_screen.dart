import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:chargerrr/core/theme/app_theme.dart';
import 'package:chargerrr/core/utils/app_constants.dart';
import 'package:chargerrr/presentation/screens/station/create/create_station_controller.dart';
import 'package:chargerrr/presentation/widgets/custom_button.dart';
import 'package:chargerrr/presentation/widgets/custom_text_field.dart';

class CreateStationScreen extends GetView<CreateStationController> {
  const CreateStationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Charging Station'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildStationDetailsSection(),
                      const SizedBox(height: 24),
                      _buildLocationSection(),
                      const SizedBox(height: 24),
                      _buildAmenitiesSection(),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStationDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Station Details',
          style: Get.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ).animate().fadeIn().slideX(begin: -0.1, end: 0, duration: 300.ms),
        const SizedBox(height: 16),
        CustomTextField(
          controller: controller.nameController,
          labelText: 'Station Name',
          hintText: 'Enter station name',
          prefixIcon: Icons.ev_station_outlined,
          validator: controller.validateName,
        ).animate().fadeIn(delay: 100.ms),
        const SizedBox(height: 16),
        CustomTextField(
          controller: controller.addressController,
          labelText: 'Address',
          hintText: 'Enter station address',
          prefixIcon: Icons.location_on_outlined,
          validator: controller.validateAddress,
        ).animate().fadeIn(delay: 200.ms),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                controller: controller.totalPointsController,
                labelText: 'Total Points',
                hintText: 'Total',
                prefixIcon: Icons.electric_bolt_outlined,
                keyboardType: TextInputType.number,
                // inputFormatters: [
                //   FilteringTextInputFormatter.digitsOnly,
                // ],
                validator: controller.validateTotalPoints,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: CustomTextField(
                controller: controller.availablePointsController,
                labelText: 'Available Points',
                hintText: 'Available',
                prefixIcon: Icons.power_outlined,
                keyboardType: TextInputType.number,
                // inputFormatters: [
                //   FilteringTextInputFormatter.digitsOnly,
                // ],
                validator: controller.validateAvailablePoints,
              ),
            ),
          ],
        ).animate().fadeIn(delay: 300.ms),
      ],
    );
  }

  Widget _buildLocationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Location',
          style: Get.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ).animate().fadeIn(delay: 400.ms),
        const SizedBox(height: 8),
        Text(
          'Tap on the map to select the station location',
          style: Get.textTheme.bodyMedium?.copyWith(
            color: Colors.grey.shade700,
          ),
        ).animate().fadeIn(delay: 450.ms),
        const SizedBox(height: 16),
        Container(
          height: 400,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Obx(() {
              return GoogleMap(
                initialCameraPosition: CameraPosition(
                  target:
                      controller.selectedLocation.value ??
                      const LatLng(
                        AppConstants.defaultLatitude,
                        AppConstants.defaultLongitude,
                      ),
                  zoom: AppConstants.defaultZoom,
                ),
                markers: controller.markers,
                onMapCreated: controller.onMapCreated,
                onTap: controller.onMapTap,
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                zoomControlsEnabled: true,
                mapToolbarEnabled: false,
              );
            }),
          ),
        ).animate().fadeIn(delay: 500.ms),
      ],
    );
  }

  Widget _buildAmenitiesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Amenities',
          style: Get.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ).animate().fadeIn(delay: 600.ms),
        const SizedBox(height: 8),
        Text(
          'Select available amenities at this station',
          style: Get.textTheme.bodyMedium?.copyWith(
            color: Colors.grey.shade700,
          ),
        ).animate().fadeIn(delay: 650.ms),
        const SizedBox(height: 16),
        Obx(() {
          return Wrap(
            spacing: 8,
            runSpacing: 8,
            children: controller.availableAmenities.map((amenity) {
              final isSelected = controller.selectedAmenities.contains(amenity);
              return FilterChip(
                label: Text(amenity),
                selected: isSelected,
                onSelected: (_) => controller.toggleAmenity(amenity),
                backgroundColor: Colors.grey.shade100,
                selectedColor: AppTheme.primaryColor.withOpacity(0.2),
                checkmarkColor: AppTheme.primaryColor,
                labelStyle: TextStyle(
                  color: isSelected ? AppTheme.primaryColor : Colors.black87,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ).animate().fadeIn(
                delay: Duration(
                  milliseconds:
                      700 + controller.availableAmenities.indexOf(amenity) * 50,
                ),
              );
            }).toList(),
          );
        }),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Get.theme.scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Obx(
            () => CustomButton(
              text: 'Create Station',
              onPressed: controller.createStation,
              isLoading: controller.isLoading.value,
              icon: Icons.add_location_alt_outlined,
            ),
          ),
        )
        .animate()
        .fadeIn(delay: 800.ms)
        .slideY(begin: 0.1, end: 0, delay: 800.ms, duration: 300.ms);
  }
}
