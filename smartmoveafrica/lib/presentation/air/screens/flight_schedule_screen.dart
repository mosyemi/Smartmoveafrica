import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_colors.dart';
import '../../../data/models/flight_info.dart';
import '../../../state/air_provider.dart';

class FlightScheduleScreen extends ConsumerWidget {
  const FlightScheduleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flightsAsync = ref.watch(flightsProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Flight Schedules')),
      body: flightsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Failed to load flights: $error')),
        data: (flights) => ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: flights.length,
          itemBuilder: (context, index) => _FlightTile(flight: flights[index]),
        ),
      ),
    );
  }
}

class _FlightTile extends StatelessWidget {
  final FlightInfo flight;
  const _FlightTile({required this.flight});

  @override
  Widget build(BuildContext context) {
    final statusColor = switch (flight.status) {
      FlightStatus.onTime => AppColors.success,
      FlightStatus.delayed => AppColors.warning,
      FlightStatus.boarding => AppColors.primary,
      FlightStatus.departed => AppColors.textGrey,
    };

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const Icon(Icons.flight_takeoff_rounded),
        title: Text('${flight.airline} ${flight.flightNumber}'),
        subtitle: Text(
          '${flight.origin} -> ${flight.destination}\n${DateFormat('HH:mm').format(flight.departureTime)}',
        ),
        trailing: Text(
          flight.status.name.toUpperCase(),
          style: TextStyle(color: statusColor, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
