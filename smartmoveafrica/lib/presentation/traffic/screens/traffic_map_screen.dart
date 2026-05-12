import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_routes.dart';
import '../../../data/models/traffic_report.dart';
import '../../../data/services/location_service.dart';
import '../../../state/location_provider.dart';
import '../../../state/traffic_reports_provider.dart';
import '../widgets/traffic_report_card.dart';

class TrafficMapScreen extends ConsumerWidget {
  const TrafficMapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reports = ref.watch(filteredTrafficReportsProvider);
    final selectedFilter = ref.watch(trafficFilterProvider);
    final location = ref.watch(locationProvider).asData?.value;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Traffic'),
        actions: [
          IconButton(
            tooltip: 'Report incident',
            onPressed: () => Navigator.pushNamed(context, AppRoutes.reportIncident),
            icon: const Icon(Icons.add_alert_rounded),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _TrafficMapPreview(reports: reports, location: location),
          const SizedBox(height: 20),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              FilterChip(
                label: const Text('All'),
                selected: selectedFilter == null,
                onSelected: (_) => ref.read(trafficFilterProvider.notifier).setFilter(null),
              ),
              for (final type in TrafficReportType.values)
                FilterChip(
                  label: Text(type.label),
                  selected: selectedFilter == type,
                  onSelected: (_) => ref.read(trafficFilterProvider.notifier).setFilter(type),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Traffic Signals',
                  style: TextStyle(
                    color: AppColors.textDark,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Text(
                '${reports.length} active',
                style: const TextStyle(
                  color: AppColors.textGrey,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          for (final report in reports) ...[
            TrafficReportCard(report: report),
            const SizedBox(height: 12),
          ],
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, AppRoutes.reportIncident),
        backgroundColor: AppColors.danger,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.warning_amber_rounded),
        label: const Text('Report'),
      ),
    );
  }
}

class _TrafficMapPreview extends StatelessWidget {
  final List<TrafficReport> reports;
  final LocationSnapshot? location;

  const _TrafficMapPreview({required this.reports, required this.location});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.darkBg,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Stack(
        children: [
          FlutterMap(
            options: const MapOptions(
              initialCenter: LatLng(-1.286389, 36.817223),
              initialZoom: 12.5,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.smartmoveafrica',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: const LatLng(-1.286389, 36.817223),
                    width: 44,
                    height: 44,
                    child: const Icon(Icons.my_location_rounded, color: AppColors.primary),
                  ),
                  for (int i = 0; i < reports.length && i < 4; i++)
                    Marker(
                      point: LatLng(-1.286389 + (i * 0.01), 36.817223 + (i * 0.012)),
                      width: 40,
                      height: 40,
                      child: Icon(Icons.warning_rounded, color: reports[i].type.color),
                    ),
                ],
              ),
            ],
          ),
          Positioned(
            left: 16,
            top: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.92),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.location_on_rounded, color: AppColors.primary, size: 18),
                  const SizedBox(width: 6),
                  Text(
                    location?.areaLabel ?? 'Nairobi area',
                    style: TextStyle(
                      color: AppColors.textDark,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: Row(
              children: const [
                _LegendDot(color: AppColors.trafficFree, label: 'Free'),
                SizedBox(width: 12),
                _LegendDot(color: AppColors.trafficSlow, label: 'Slow'),
                SizedBox(width: 12),
                _LegendDot(color: AppColors.trafficJam, label: 'Jam'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendDot({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 9,
            height: 9,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textDark,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
