import 'package:flutter_test/flutter_test.dart';
import 'package:smartmoveafrica/data/models/matatu_vehicle.dart';
import 'package:smartmoveafrica/data/models/traffic_report.dart';
import 'package:smartmoveafrica/data/services/ai_analytics_service.dart';

void main() {
  final service = AiAnalyticsService();

  test('predictCongestionScore returns a bounded score', () {
    final score = service.predictCongestionScore(
      reports: [
        TrafficReport(
          id: '1',
          type: TrafficReportType.accident,
          location: 'A',
          description: 'desc',
          reportedAt: DateTime.now(),
        ),
      ],
      vehicles: const [
        MatatuVehicle(
          id: 'm1',
          routeName: 'CBD',
          plateNumber: 'KAA',
          etaMinutes: 12,
          status: MatatuStatus.delayed,
          baseFareKes: 80,
          distanceKm: 5,
        ),
      ],
    );
    expect(score, inInclusiveRange(0, 100));
  });
}
