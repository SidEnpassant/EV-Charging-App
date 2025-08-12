import 'package:chargerrr/data/datasources/remote/supabase_station_datasource.dart';
import 'package:chargerrr/data/models/charging_station_model.dart';
import 'package:chargerrr/domain/entities/charging_station.dart';
import 'package:chargerrr/domain/repositories/station_repository.dart';

class StationRepositoryImpl implements StationRepository {
  final SupabaseStationDataSource _stationDataSource;

  StationRepositoryImpl(this._stationDataSource);

  @override
  Future<List<ChargingStation>> getStations() {
    return _stationDataSource.getStations();
  }

  @override
  Future<ChargingStation> getStationDetails(String stationId) {
    return _stationDataSource.getStationDetails(stationId);
  }

  @override
  Future<ChargingStation> createStation(ChargingStation station) {
    final stationModel = ChargingStationModel(
      id:
          station.id ??
          '', // This will be ignored by Supabase when creating a new record
      name: station.name,
      address: station.address,
      latitude: station.latitude,
      longitude: station.longitude,
      availablePoints: station.availablePoints,
      totalPoints: station.totalPoints,
      amenities: station.amenities,
      createdAt: station.createdAt,
      createdBy: station.createdBy,
    );

    return _stationDataSource.createStation(stationModel);
  }
}
