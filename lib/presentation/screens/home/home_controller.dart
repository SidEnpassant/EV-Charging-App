import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chargerrr/core/routes/app_pages.dart';
import 'package:chargerrr/domain/entities/charging_station.dart';
import 'package:chargerrr/domain/entities/user.dart';
import 'package:chargerrr/domain/usecases/auth/get_current_user_usecase.dart';
import 'package:chargerrr/domain/usecases/auth/logout_usecase.dart';
import 'package:chargerrr/domain/usecases/station/get_stations_usecase.dart';

class HomeController extends GetxController {
  final GetStationsUseCase _getStationsUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;
  final LogoutUseCase _logoutUseCase;

  HomeController(
    this._getStationsUseCase,
    this._getCurrentUserUseCase,
    this._logoutUseCase,
  );

  final stations = <ChargingStation>[].obs;
  final filteredStations = <ChargingStation>[].obs;
  final isLoading = true.obs;
  final errorMessage = RxnString(null);
  final currentUser = Rxn<User>();
  final searchController = TextEditingController();
  final selectedFilter = RxString('all');

  @override
  void onInit() {
    super.onInit();
    loadCurrentUser();
    loadStations();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  Future<void> loadCurrentUser() async {
    try {
      final user = await _getCurrentUserUseCase();
      currentUser.value = user;
    } catch (e) {
      debugPrint('Error loading current user: $e');
    }
  }

  Future<void> loadStations() async {
    isLoading.value = true;
    errorMessage.value = null;

    try {
      final result = await _getStationsUseCase();
      stations.value = result;
      applyFilters();
    } catch (e) {
      errorMessage.value = 'Failed to load charging stations: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }

  void applyFilters() {
    final searchTerm = searchController.text.toLowerCase();

    filteredStations.value = stations.where((station) {
      // Apply search filter
      final matchesSearch =
          searchTerm.isEmpty ||
          station.name.toLowerCase().contains(searchTerm) ||
          station.address.toLowerCase().contains(searchTerm);

      // Apply availability filter
      bool matchesAvailability = true;
      if (selectedFilter.value == 'available') {
        matchesAvailability = station.availablePoints > 0;
      }

      return matchesSearch && matchesAvailability;
    }).toList();
  }

  void onSearchChanged(String value) {
    applyFilters();
  }

  void setFilter(String filter) {
    selectedFilter.value = filter;
    applyFilters();
  }

  void navigateToStationDetails(String stationId) {
    Get.toNamed(Routes.stationDetails, arguments: stationId);
  }

  void navigateToCreateStation() {
    Get.toNamed(Routes.stationCreation);
  }

  Future<void> refreshStations() async {
    await loadStations();
  }

  Future<void> logout() async {
    try {
      await _logoutUseCase();
      Get.offAllNamed(Routes.login);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to logout: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void navigateToProfile() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(
              () => ListTile(
                leading: CircleAvatar(
                  child: Text(
                    currentUser.value?.name?.isNotEmpty == true
                        ? currentUser.value!.name![0].toUpperCase()
                        : '?',
                  ),
                ),
                title: Text(currentUser.value?.name ?? 'User Profile'),
                subtitle: Text(currentUser.value?.email ?? ''),
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.exit_to_app, color: Colors.red),
              title: const Text('Logout', style: TextStyle(color: Colors.red)),
              onTap: () {
                Get.back();
                logout();
              },
            ),
          ],
        ),
      ),
    );
  }
}
