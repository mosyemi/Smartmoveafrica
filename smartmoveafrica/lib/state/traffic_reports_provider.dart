
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/traffic_report.dart';
import '../data/repositories/traffic_repository.dart';

final trafficRepositoryProvider = Provider<TrafficRepository>((ref) => MockTrafficRepository());
final trafficFilterProvider =
    NotifierProvider<TrafficFilterNotifier, TrafficReportType?>(TrafficFilterNotifier.new);

final trafficReportsProvider = NotifierProvider<TrafficReportsNotifier, List<TrafficReport>>(
  TrafficReportsNotifier.new,
);

final filteredTrafficReportsProvider = Provider<List<TrafficReport>>((ref) {
  final reports = ref.watch(trafficReportsProvider);
  final filter = ref.watch(trafficFilterProvider);
  if (filter == null) return reports;
  return reports.where((report) => report.type == filter).toList();
});

class TrafficReportsNotifier extends Notifier<List<TrafficReport>> {
  @override
  List<TrafficReport> build() {
    final repo = ref.read(trafficRepositoryProvider);
    repo.fetchReports().then((value) => state = value);
    return const [];
  }

  void addReport({
    required TrafficReportType type,
    required String location,
    required String description,
  }) {
    final report = TrafficReport(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      type: type,
      location: location,
      description: description,
      reportedAt: DateTime.now(),
    );
    state = [report, ...state];
    ref.read(trafficRepositoryProvider).saveReports(state);
  }
}

class TrafficFilterNotifier extends Notifier<TrafficReportType?> {
  @override
  TrafficReportType? build() => null;

  void setFilter(TrafficReportType? filter) {
    state = filter;
  }
}
