import '../models/matatu_vehicle.dart';
import '../models/route_recommendation.dart';
import '../models/traffic_report.dart';

class AiAnalyticsService {
  int predictCongestionScore({
    required List<TrafficReport> reports,
    required List<MatatuVehicle> vehicles,
  }) {
    final incidentWeight = reports.length * 9;
    final delayedVehicles = vehicles.where((v) => v.status == MatatuStatus.delayed).length;
    final crowdWeight = vehicles.where((v) => v.status == MatatuStatus.crowded).length * 7;
    final score = 20 + incidentWeight + (delayedVehicles * 8) + crowdWeight;
    return score.clamp(0, 100);
  }

  List<RouteRecommendation> recommendRoutes({
    required List<TrafficReport> reports,
    required List<MatatuVehicle> vehicles,
  }) {
    final hasFlood = reports.any((r) => r.type == TrafficReportType.flood);
    final hasAccident = reports.any((r) => r.type == TrafficReportType.accident);
    final peakLoad = vehicles.where((v) => v.status == MatatuStatus.crowded).length;

    return [
      RouteRecommendation(
        title: 'Upper Hill Bypass',
        summary: hasAccident
            ? 'Recommended due to active accident reports on Mombasa Road.'
            : 'Stable corridor with predictable flow this hour.',
        estimatedMinutes: peakLoad > 1 ? 34 : 29,
        confidencePercent: 82,
      ),
      RouteRecommendation(
        title: 'Waiyaki Express Link',
        summary: hasFlood
            ? 'Avoid low-lying segments, use elevated link exits.'
            : 'Consistent speed and fewer stoppages.',
        estimatedMinutes: 27,
        confidencePercent: 78,
      ),
    ];
  }
}
