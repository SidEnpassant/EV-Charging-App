import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:chargerrr/core/utils/app_constants.dart';
import 'package:chargerrr/data/models/charging_station_model.dart';

abstract class SupabaseStationDataSource {
  Future<List<ChargingStationModel>> getStations();
  Future<ChargingStationModel> getStationDetails(String stationId);
  Future<ChargingStationModel> createStation(ChargingStationModel station);
}

class SupabaseStationDataSourceImpl implements SupabaseStationDataSource {
  final _supabase = Supabase.instance.client;

  @override
  Future<List<ChargingStationModel>> getStations() async {
    try {
      final response = await _supabase
          .from(AppConstants.chargingStationsCollection)
          .select()
          .order('created_at', ascending: false);

      return response
          .map<ChargingStationModel>(
            (json) => ChargingStationModel.fromJson(json),
          )
          .toList();
    } catch (e) {
      throw Exception('Failed to get stations: ${e.toString()}');
    }
  }

  @override
  Future<ChargingStationModel> getStationDetails(String stationId) async {
    try {
      final response = await _supabase
          .from(AppConstants.chargingStationsCollection)
          .select()
          .eq('id', stationId)
          .single();

      return ChargingStationModel.fromJson(response);
    } catch (e) {
      throw Exception('Failed to get station details: ${e.toString()}');
    }
  }

  @override
  Future<ChargingStationModel> createStation(
    ChargingStationModel station,
  ) async {
    try {
      final currentUser = _supabase.auth.currentUser;

      if (currentUser == null) {
        throw Exception('User not authenticated');
      }

      final stationData = station.toJson();
      // Remove the id field to let Supabase generate a UUID
      stationData.remove('id');
      stationData['created_by'] = currentUser.id;
      stationData['created_at'] = DateTime.now().toIso8601String();

      final response = await _supabase
          .from(AppConstants.chargingStationsCollection)
          .insert(stationData)
          .select()
          .single();

      return ChargingStationModel.fromJson(response);
    } catch (e) {
      throw Exception('Failed to create station: ${e.toString()}');
    }
  }
}
