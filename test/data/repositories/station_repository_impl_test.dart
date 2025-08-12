import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:chargerrr/data/datasources/remote/supabase_station_datasource.dart';
import 'package:chargerrr/data/models/charging_station_model.dart';
import 'package:chargerrr/data/repositories/station_repository_impl.dart';
import 'package:chargerrr/domain/entities/charging_station.dart';

@GenerateMocks([SupabaseStationDataSource])
import 'station_repository_impl_test.mocks.dart';

void main() {
  late StationRepositoryImpl repository;
  late MockSupabaseStationDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockSupabaseStationDataSource();
    repository = StationRepositoryImpl(mockDataSource);
  });

  final testDate = DateTime.now();
  final testStationModel = ChargingStationModel(
    id: 'test-id',
    name: 'Test Station',
    address: '123 Test St, Test City',
    latitude: 37.7749,
    longitude: -122.4194,
    availablePoints: 3,
    totalPoints: 5,
    amenities: ['WiFi', 'Restrooms'],
    createdAt: testDate,
    createdBy: 'user-id',
  );

  final testStationsList = [testStationModel];

  group('getStations', () {
    test('should return list of charging stations when call is successful', () async {
      // Arrange
      when(mockDataSource.getStations())
          .thenAnswer((_) async => testStationsList);

      // Act
      final result = await repository.getStations();

      // Assert
      expect(result, equals(testStationsList));
      verify(mockDataSource.getStations());
      verifyNoMoreInteractions(mockDataSource);
    });

    test('should throw exception when data source call fails', () async {
      // Arrange
      when(mockDataSource.getStations())
          .thenThrow(Exception('Failed to load stations'));

      // Act & Assert
      expect(
        () => repository.getStations(),
        throwsA(isA<Exception>()),
      );
      verify(mockDataSource.getStations());
      verifyNoMoreInteractions(mockDataSource);
    });
  });

  group('getStationDetails', () {
    test('should return station details when call is successful', () async {
      // Arrange
      const stationId = 'test-id';
      when(mockDataSource.getStationDetails(stationId))
          .thenAnswer((_) async => testStationModel);

      // Act
      final result = await repository.getStationDetails(stationId);

      // Assert
      expect(result, equals(testStationModel));
      verify(mockDataSource.getStationDetails(stationId));
      verifyNoMoreInteractions(mockDataSource);
    });

    test('should throw exception when data source call fails', () async {
      // Arrange
      const stationId = 'test-id';
      when(mockDataSource.getStationDetails(stationId))
          .thenThrow(Exception('Station not found'));

      // Act & Assert
      expect(
        () => repository.getStationDetails(stationId),
        throwsA(isA<Exception>()),
      );
      verify(mockDataSource.getStationDetails(stationId));
      verifyNoMoreInteractions(mockDataSource);
    });
  });

  group('createStation', () {
    test('should create station when call is successful', () async {
      // Arrange
      const name = 'New Station';
      const address = '456 New St, New City';
      const latitude = 37.7749;
      const longitude = -122.4194;
      const totalPoints = 5;
      const availablePoints = 3;
      final amenities = ['WiFi', 'Restrooms'];

      when(mockDataSource.createStation(
        name: name,
        address: address,
        latitude: latitude,
        longitude: longitude,
        totalPoints: totalPoints,
        availablePoints: availablePoints,
        amenities: amenities,
      )).thenAnswer((_) async => testStationModel);

      // Act
      final result = await repository.createStation(
        name: name,
        address: address,
        latitude: latitude,
        longitude: longitude,
        totalPoints: totalPoints,
        availablePoints: availablePoints,
        amenities: amenities,
      );

      // Assert
      expect(result, equals(testStationModel));
      verify(mockDataSource.createStation(
        name: name,
        address: address,
        latitude: latitude,
        longitude: longitude,
        totalPoints: totalPoints,
        availablePoints: availablePoints,
        amenities: amenities,
      ));
      verifyNoMoreInteractions(mockDataSource);
    });

    test('should throw exception when data source call fails', () async {
      // Arrange
      const name = 'New Station';
      const address = '456 New St, New City';
      const latitude = 37.7749;
      const longitude = -122.4194;
      const totalPoints = 5;
      const availablePoints = 3;
      final amenities = ['WiFi', 'Restrooms'];

      when(mockDataSource.createStation(
        name: name,
        address: address,
        latitude: latitude,
        longitude: longitude,
        totalPoints: totalPoints,
        availablePoints: availablePoints,
        amenities: amenities,
      )).thenThrow(Exception('Failed to create station'));

      // Act & Assert
      expect(
        () => repository.createStation(
          name: name,
          address: address,
          latitude: latitude,
          longitude: longitude,
          totalPoints: totalPoints,
          availablePoints: availablePoints,
          amenities: amenities,
        ),
        throwsA(isA<Exception>()),
      );
      verify(mockDataSource.createStation(
        name: name,
        address: address,
        latitude: latitude,
        longitude: longitude,
        totalPoints: totalPoints,
        availablePoints: availablePoints,
        amenities: amenities,
      ));
      verifyNoMoreInteractions(mockDataSource);
    });
  });
}