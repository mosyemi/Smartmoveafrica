import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

enum TrafficReportType {
  accident,
  jam,
  roadblock,
  flood,
}

extension TrafficReportTypeLabel on TrafficReportType {
  String get label {
    switch (this) {
      case TrafficReportType.accident:
        return 'Accident';
      case TrafficReportType.jam:
        return 'Traffic jam';
      case TrafficReportType.roadblock:
        return 'Roadblock';
      case TrafficReportType.flood:
        return 'Flooding';
    }
  }

  IconData get icon {
    switch (this) {
      case TrafficReportType.accident:
        return Icons.car_crash_rounded;
      case TrafficReportType.jam:
        return Icons.traffic_rounded;
      case TrafficReportType.roadblock:
        return Icons.block_rounded;
      case TrafficReportType.flood:
        return Icons.water_drop_rounded;
    }
  }

  Color get color {
    switch (this) {
      case TrafficReportType.accident:
        return AppColors.danger;
      case TrafficReportType.jam:
        return AppColors.warning;
      case TrafficReportType.roadblock:
        return AppColors.primary;
      case TrafficReportType.flood:
        return AppColors.secondary;
    }
  }
}

class TrafficReport {
  final String id;
  final TrafficReportType type;
  final String location;
  final String description;
  final DateTime reportedAt;

  const TrafficReport({
    required this.id,
    required this.type,
    required this.location,
    required this.description,
    required this.reportedAt,
  });
}
