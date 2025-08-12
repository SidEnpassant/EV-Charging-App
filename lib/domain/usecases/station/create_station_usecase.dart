import 'package:chargerrr/domain/entities/charging_station.dart';
import 'package:chargerrr/domain/repositories/station_repository.dart';

class CreateStationUseCase {
  final StationRepository _stationRepository;

  CreateStationUseCase(this._stationRepository);

  Future<ChargingStation> call(ChargingStation station) {
    return _stationRepository.createStation(station);
  }
}
