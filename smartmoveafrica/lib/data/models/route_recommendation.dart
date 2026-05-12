class RouteRecommendation {
  final String title;
  final String summary;
  final int estimatedMinutes;
  final int confidencePercent;

  const RouteRecommendation({
    required this.title,
    required this.summary,
    required this.estimatedMinutes,
    required this.confidencePercent,
  });
}
