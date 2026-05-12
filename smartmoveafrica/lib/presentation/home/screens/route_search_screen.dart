import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_colors.dart';
import '../../../state/ai_insights_provider.dart';

class RouteSearchScreen extends ConsumerWidget {
  const RouteSearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final insights = ref.watch(aiInsightsProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Route Search')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.analytics_rounded),
              title: const Text('Congestion score'),
              subtitle: Text('${insights.congestionScore}/100'),
            ),
          ),
          const SizedBox(height: 8),
          for (final recommendation in insights.recommendations)
            Card(
              child: ListTile(
                leading: const Icon(Icons.route_rounded),
                title: Text(recommendation.title),
                subtitle: Text(recommendation.summary),
                trailing: Text('${recommendation.estimatedMinutes}m'),
              ),
            ),
        ],
      ),
    );
  }
}
