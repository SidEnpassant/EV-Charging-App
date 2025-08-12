class ChargingStation {
  final String? id;
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final int availablePoints;
  final int totalPoints;
  final List<String> amenities;
  final DateTime? createdAt;
  final String? createdBy;

  ChargingStation({
    this.id,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.availablePoints,
    required this.totalPoints,
    required this.amenities,
    this.createdAt,
    this.createdBy,
  });
}
