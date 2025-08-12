import 'package:flutter/material.dart';
import 'package:chargerrr/core/theme/app_theme.dart';
import 'package:chargerrr/domain/entities/charging_station.dart';

class MapInfoWindow extends StatelessWidget {
  final ChargingStation station;
  final VoidCallback onNavigate;
  final VoidCallback onClose;

  const MapInfoWindow({
    Key? key,
    required this.station,
    required this.onNavigate,
    required this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final availabilityColor = station.availablePoints > 0
        ? Colors.green.shade700
        : Colors.red.shade700;

    return Container(
      width: 250,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  station.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              GestureDetector(
                onTap: onClose,
                child: const Icon(Icons.close, size: 18),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: availabilityColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: availabilityColor.withOpacity(0.5)),
                ),
                child: Text(
                  '${station.availablePoints}/${station.totalPoints} Available',
                  style: TextStyle(
                    color: availabilityColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (station.amenities.isNotEmpty) ...[
            Wrap(
              spacing: 4,
              runSpacing: 4,
              children: station.amenities.take(3).map((amenity) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    amenity,
                    style: TextStyle(fontSize: 10, color: Colors.grey.shade800),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 8),
          ],
          ElevatedButton.icon(
            onPressed: onNavigate,
            icon: const Icon(Icons.directions, size: 16),
            label: const Text('Navigate'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 36),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              textStyle: const TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
