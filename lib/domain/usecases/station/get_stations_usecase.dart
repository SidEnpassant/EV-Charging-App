import 'package:chargerrr/domain/entities/charging_station.dart';
import 'package:chargerrr/domain/repositories/station_repository.dart';

class GetStationsUseCase {
  final StationRepository _stationRepository;

  GetStationsUseCase(this._stationRepository);

  Future<List<ChargingStation>> call() {
    return _stationRepository.getStations();
  }
}