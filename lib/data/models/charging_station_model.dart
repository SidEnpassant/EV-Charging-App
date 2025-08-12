import 'package:chargerrr/domain/entities/charging_station.dart';

class ChargingStationModel extends ChargingStation {
  ChargingStationModel({
    required String id,
    required String name,
    required String address,
    required double latitude,
    required double longitude,
    required int availablePoints,
    required int totalPoints,
    required List<String> amenities,
    DateTime? createdAt,
    String? createdBy,
  }) : super(
          id: id,
          name: name,
          address: address,
          latitude: latitude,
          longitude: longitude,
          availablePoints: availablePoints,
          totalPoints: totalPoints,
          amenities: amenities,
          createdAt: createdAt,
          createdBy: createdBy,
        );

  factory ChargingStationModel.fromJson(Map<String, dynamic> json) {
    return ChargingStationModel(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
      availablePoints: json['available_points'],
      totalPoints: json['total_points'],
      amenities: List<String>.from(json['amenities']),
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      createdBy: json['created_by'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'available_points': availablePoints,
      'total_points': totalPoints,
      'amenities': amenities,
      'created_at': createdAt?.toIso8601String(),
      'created_by': createdBy,
    };
  }
}