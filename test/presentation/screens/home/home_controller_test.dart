import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:chargerrr/domain/entities/charging_station.dart';
import 'package:chargerrr/domain/entities/user.dart';
import 'package:chargerrr/domain/usecases/auth/get_current_user_usecase.dart';
import 'package:chargerrr/domain/usecases/auth/logout_usecase.dart';
import 'package:chargerrr/domain/usecases/station/get_stations_usecase.dart';
import 'package:chargerrr/presentation/screens/home/home_controller.dart';

@GenerateMocks([GetStationsUseCase, GetCurrentUserUseCase, LogoutUseCase])
import 'home_controller_test.mocks.dart';

void main() {
  late HomeController controller;
  late MockGetStationsUseCase mockGetStationsUseCase;
  late MockGetCurrentUserUseCase mockGetCurrentUserUseCase;
  late MockLogoutUseCase mockLogoutUseCase;

  setUp(() {
    mockGetStationsUseCase = MockGetStationsUseCase();
    mockGetCurrentUserUseCase = MockGetCurrentUserUseCase();
    mockLogoutUseCase = MockLogoutUseCase();
    controller = HomeController(
      mockGetStationsUseCase,
      mockGetCurrentUserUseCase,
      mockLogoutUseCase,
    );
  });

  final testDate = DateTime.now();
  final testUser = User(
    id: 'test-user-id',
    email: 'test@example.com',
    name: 'Test User',
    avatarUrl: null,
    createdAt: testDate,
  );

  final testStations = [
    ChargingStation(
      id: 'station-1',
      name: 'Test Station 1',
      address: '123 Test St',
      latitude: 37.7749,
      longitude: -122.4194,
      availablePoints: 3,
      totalPoints: 5,
      amenities: ['WiFi', 'Restrooms'],
      createdAt: testDate,
      createdBy: 'user-id',
    ),
    ChargingStation(
      id: 'station-2',
      name: 'Test Station 2',
      address: '456 Example Ave',
      latitude: 37.7750,
      longitude: -122.4195,
      availablePoints: 0,
      totalPoints: 2,
      amenities: ['Parking'],
      createdAt: testDate,
      createdBy: 'user-id',
    ),
  ];

  group('HomeController', () {
    test('should load current user on init', () async {
      // Arrange
      when(mockGetCurrentUserUseCase())
          .thenAnswer((_) async => testUser);
      when(mockGetStationsUseCase())
          .thenAnswer((_) async => testStations);

      // Act
      await controller.loadCurrentUser();

      // Assert
      expect(controller.currentUser.value, equals(testUser));
      verify(mockGetCurrentUserUseCase());
    });

    test('should load stations on init', () async {
      // Arrange
      when(mockGetStationsUseCase())
          .thenAnswer((_) async => testStations);

      // Act
      await controller.loadStations();

      // Assert
      expect(controller.isLoading.value, isFalse);
      expect(controller.stations.length, equals(2));
      expect(controller.filteredStations.length, equals(2));
      verify(mockGetStationsUseCase());
    });

    test('should filter stations by availability', () async {
      // Arrange
      when(mockGetStationsUseCase())
          .thenAnswer((_) async => testStations);
      await controller.loadStations();

      // Act
      controller.setFilter('available');

      // Assert
      expect(controller.filteredStations.length, equals(1));
      expect(controller.filteredStations[0].id, equals('station-1'));
    });

    test('should filter stations by search term', () async {
      // Arrange
      when(mockGetStationsUseCase())
          .thenAnswer((_) async => testStations);
      await controller.loadStations();
      controller.searchController.text = 'example';

      // Act
      controller.onSearchChanged('example');

      // Assert
      expect(controller.filteredStations.length, equals(1));
      expect(controller.filteredStations[0].id, equals('station-2'));
    });

    test('should handle error when loading stations fails', () async {
      // Arrange
      when(mockGetStationsUseCase())
          .thenThrow(Exception('Failed to load stations'));

      // Act
      await controller.loadStations();

      // Assert
      expect(controller.isLoading.value, isFalse);
      expect(controller.errorMessage.value, isNotNull);
      expect(controller.stations.isEmpty, isTrue);
      verify(mockGetStationsUseCase());
    });
  });
}