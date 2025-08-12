import 'package:chargerrr/domain/entities/charging_station.dart';

abstract class StationRepository {
  Future<List<ChargingStation>> getStations();
  Future<ChargingStation> getStationDetails(String stationId);
  Future<ChargingStation> createStation(ChargingStation station);
}