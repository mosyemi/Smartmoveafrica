import '../models/traffic_report.dart';

abstract class TrafficRepository {
  Future<List<TrafficReport>> fetchReports();
  Future<void> saveReports(List<TrafficReport> reports);
}

class MockTrafficRepository implements TrafficRepository {
  List<TrafficReport> _reports = [
    TrafficReport(
      id: 'demo-1',
      type: TrafficReportType.jam,
      location: 'Mombasa Road near Nyayo Stadium',
      description: 'Slow-moving traffic heading toward Nairobi CBD.',
      reportedAt: DateTime.now().subtract(const Duration(minutes: 12)),
    ),
    TrafficReport(
      id: 'demo-2',
      type: TrafficReportType.roadblock,
      location: 'Waiyaki Way at Kangemi',
      description: 'Police checkpoint causing minor delays.',
      reportedAt: DateTime.now().subtract(const Duration(minutes: 28)),
    ),
    TrafficReport(
      id: 'demo-3',
      type: TrafficReportType.accident,
      location: 'Thika Road near Garden City',
      description: 'Two-lane obstruction. Use service lane where possible.',
      reportedAt: DateTime.now().subtract(const Duration(minutes: 41)),
    ),
  ];

  @override
  Future<List<TrafficReport>> fetchReports() async {
    return _reports;
  }

  @override
  Future<void> saveReports(List<TrafficReport> reports) async {
    _reports = reports;
  }
}
