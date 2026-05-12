import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_colors.dart';
import '../../../state/air_provider.dart';

class AirportMonitorScreen extends ConsumerWidget {
  const AirportMonitorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statusAsync = ref.watch(airportStatusProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Airport Monitor')),
      body: statusAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Unable to load airport status: $error')),
        data: (status) => Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _InfoCard(
                title: 'Airport',
                value: status.airportCode,
                icon: Icons.local_airport_rounded,
              ),
              _InfoCard(
                title: 'Active flights',
                value: status.activeFlights.toString(),
                icon: Icons.flight_rounded,
              ),
              _InfoCard(
                title: 'Delays',
                value: status.delayedFlights.toString(),
                icon: Icons.warning_amber_rounded,
              ),
              _InfoCard(
                title: 'Airspace',
                value: status.airspaceCondition,
                icon: Icons.public_rounded,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  const _InfoCard({required this.title, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary),
        title: Text(title),
        subtitle: Text(value),
      ),
    );
  }
}
