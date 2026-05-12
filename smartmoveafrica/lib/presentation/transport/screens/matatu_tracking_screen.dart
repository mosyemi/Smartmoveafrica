import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_colors.dart';
import '../../../data/models/matatu_vehicle.dart';
import '../../../state/transport_provider.dart';

class MatatuTrackingScreen extends ConsumerWidget {
  const MatatuTrackingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vehiclesAsync = ref.watch(transportProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Matatu Tracking')),
      body: vehiclesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Failed to load vehicles: $error')),
        data: (vehicles) {
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: vehicles.length,
            itemBuilder: (context, index) {
              final vehicle = vehicles[index];
              final fare = ref.read(transportProvider.notifier).fareFor(vehicle);
              return _VehicleCard(vehicle: vehicle, fare: fare);
            },
          );
        },
      ),
    );
  }
}

class _VehicleCard extends StatelessWidget {
  final MatatuVehicle vehicle;
  final double fare;

  const _VehicleCard({required this.vehicle, required this.fare});

  @override
  Widget build(BuildContext context) {
    final statusColor = switch (vehicle.status) {
      MatatuStatus.onTime => AppColors.success,
      MatatuStatus.delayed => AppColors.warning,
      MatatuStatus.crowded => AppColors.danger,
    };
    final statusLabel = switch (vehicle.status) {
      MatatuStatus.onTime => 'On time',
      MatatuStatus.delayed => 'Delayed',
      MatatuStatus.crowded => 'Crowded',
    };
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      color: colorScheme.surface,
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    vehicle.routeName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(statusLabel, style: TextStyle(color: statusColor)),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Plate: ${vehicle.plateNumber}',
              style: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 13),
            ),
            Text(
              'ETA: ${vehicle.etaMinutes} min',
              style: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 13),
            ),
            Text(
              'Estimated fare: KES ${fare.toStringAsFixed(0)}',
              style: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
