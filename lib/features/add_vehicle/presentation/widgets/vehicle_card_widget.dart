import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vehicle_list_app/features/add_vehicle/data/model/vehicle_model.dart';

class VehicleCardWidget extends StatelessWidget {
  final VehicleModel vehicle;
  final Color color;

  const VehicleCardWidget({
    super.key,
    required this.vehicle,
    required this.color,
  });

  String _getEfficiencyStatus() {
    final currentYear = DateTime.now().year;
    final age = currentYear - vehicle.manufacturingYear;

    if (vehicle.fuelEfficiency >= 15 && age <= 5) {
      return 'Fuel Efficient & Low Pollutant';
    } else if (vehicle.fuelEfficiency >= 15) {
      return 'Fuel Efficient & Moderate Pollutant';
    }
    return 'Inefficient & High Pollutant';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      child: Container(
        decoration: BoxDecoration(
          border: Border(left: BorderSide(color: color, width: 8)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                vehicle.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.local_gas_station, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Text(
                    '${vehicle.fuelEfficiency} km/l',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  const SizedBox(width: 16),
                  Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Text(
                    vehicle.manufacturingYear.toString(),
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  _getEfficiencyStatus(),
                  style: TextStyle(
                    color: color,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Added on: ${_formatDate(vehicle.createdAt)}',
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(Timestamp timestamp) {
    final date = timestamp.toDate();
    return '${date.day}/${date.month}/${date.year}';
  }
}