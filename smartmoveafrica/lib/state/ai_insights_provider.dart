import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/route_recommendation.dart';
import '../data/services/ai_analytics_service.dart';
import 'traffic_reports_provider.dart';
import 'transport_provider.dart';

class AiInsights {
  final int congestionScore;
  final List<RouteRecommendation> recommendations;

  const AiInsights({
    required this.congestionScore,
    required this.recommendations,
  });
}

final aiAnalyticsServiceProvider = Provider<AiAnalyticsService>(
  (ref) => AiAnalyticsService(),
);

final aiInsightsProvider = Provider<AiInsights>((ref) {
  final reports = ref.watch(trafficReportsProvider);
  final vehicles = ref.watch(transportProvider).asData?.value ?? const [];
  final service = ref.watch(aiAnalyticsServiceProvider);
  return AiInsights(
    congestionScore: service.predictCongestionScore(reports: reports, vehicles: vehicles),
    recommendations: service.recommendRoutes(reports: reports, vehicles: vehicles),
  );
});
