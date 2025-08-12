import 'package:chargerrr/domain/entities/charging_station.dart';
import 'package:chargerrr/domain/repositories/station_repository.dart';

class GetStationDetailsUseCase {
  final StationRepository _stationRepository;

  GetStationDetailsUseCase(this._stationRepository);

  Future<ChargingStation> call(String stationId) {
    return _stationRepository.getStationDetails(stationId);
  }
}