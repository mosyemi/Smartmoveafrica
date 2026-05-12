import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_routes.dart';
import '../../../state/ai_insights_provider.dart';
import '../../../state/air_provider.dart';
import '../../../state/traffic_reports_provider.dart';
import '../../../state/transport_provider.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/bottom_nav_bar.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});
  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final incidents = ref.watch(trafficReportsProvider).length;
    final vehicles = ref.watch(transportProvider).asData?.value.length ?? 0;
    final flights = ref.watch(flightsProvider).asData?.value.length ?? 0;
    final aiScore = ref.watch(aiInsightsProvider).congestionScore;
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 120,
              floating: true,
              backgroundColor: AppColors.primary,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.primary, Color(0xFF1565C0)],
                    ),
                  ),
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Good Morning 👋', style: TextStyle(color: Colors.white70, fontSize: 13)),
                              const SizedBox(height: 2),
                              const Text('Welcome Back!', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800)),
                            ],
                          ),
                          CircleAvatar(
                            radius: 22,
                            backgroundColor: Colors.white.withValues(alpha: 0.2),
                            child: const Icon(Icons.person, color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Search bar
                    Container(
                      decoration: BoxDecoration(
                        color: colorScheme.surface,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          if (Theme.of(context).brightness == Brightness.light)
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.06),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                        ],
                      ),
                      child: TextField(
                        style: TextStyle(color: colorScheme.onSurface),
                        decoration: InputDecoration(
                          hintText: 'Search routes, places...',
                          hintStyle: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 14),
                          prefixIcon: Icon(Icons.search, color: colorScheme.primary),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    Text(
                      'Quick Access',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: colorScheme.onSurface),
                    ),
                    const SizedBox(height: 14),

                    // Quick access grid
                    GridView.count(
                      crossAxisCount: 4,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      children: [
                        _QuickAccessItem(
                            icon: Icons.traffic_rounded,
                            label: 'Traffic',
                            color: AppColors.primary,
                            labelColor: colorScheme.onSurface,
                            onTap: () => Navigator.pushNamed(context, AppRoutes.trafficMap)),
                        _QuickAccessItem(
                            icon: Icons.directions_bus_filled_rounded,
                            label: 'Matatu',
                            color: const Color(0xFF00897B),
                            labelColor: colorScheme.onSurface,
                            onTap: () => Navigator.pushNamed(context, AppRoutes.matatuTrack)),
                        _QuickAccessItem(
                            icon: Icons.flight_rounded,
                            label: 'Flights',
                            color: const Color(0xFF6A1B9A),
                            labelColor: colorScheme.onSurface,
                            onTap: () => Navigator.pushNamed(context, AppRoutes.flightSchedule)),
                        _QuickAccessItem(
                            icon: Icons.warning_amber_rounded,
                            label: 'Report',
                            color: AppColors.danger,
                            labelColor: colorScheme.onSurface,
                            onTap: () => Navigator.pushNamed(context, AppRoutes.reportIncident)),
                      ],
                    ),
                    const SizedBox(height: 24),

                    Text(
                      'Live Overview',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: colorScheme.onSurface),
                    ),
                    const SizedBox(height: 14),

                    DashboardCard(
                      title: 'Traffic Status',
                      subtitle: '$incidents incidents reported, score $aiScore/100',
                      icon: Icons.traffic_rounded,
                      color: AppColors.warning,
                      badge: 'MODERATE',
                      badgeColor: AppColors.warning,
                      onTap: () => Navigator.pushNamed(context, AppRoutes.trafficMap),
                    ),
                    const SizedBox(height: 12),
                    DashboardCard(
                      title: 'Matatu Tracking',
                      subtitle: '$vehicles vehicles active on monitored routes',
                      icon: Icons.directions_bus_filled_rounded,
                      color: const Color(0xFF00897B),
                      badge: 'LIVE',
                      badgeColor: AppColors.success,
                      onTap: () => Navigator.pushNamed(context, AppRoutes.matatuTrack),
                    ),
                    const SizedBox(height: 12),
                    DashboardCard(
                      title: 'Flights',
                      subtitle: '$flights flights loaded from airport monitor',
                      icon: Icons.flight_rounded,
                      color: const Color(0xFF6A1B9A),
                      badge: 'UPDATED',
                      badgeColor: AppColors.primary,
                      onTap: () => Navigator.pushNamed(context, AppRoutes.flightSchedule),
                    ),
                    const SizedBox(height: 12),
                    DashboardCard(
                      title: 'Smart Route Search',
                      subtitle: 'AI-generated alternatives and travel time suggestions',
                      icon: Icons.route_rounded,
                      color: const Color(0xFF5D4037),
                      badge: 'AI',
                      badgeColor: AppColors.secondary,
                      onTap: () => Navigator.pushNamed(context, AppRoutes.routeSearch),
                    ),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(
        selectedIndex: _selectedIndex,
        onTap: _handleBottomNavTap,
      ),
    );
  }

  void _handleBottomNavTap(int index) {
    setState(() => _selectedIndex = index);

    switch (index) {
      case 0:
        break;
      case 1:
        Navigator.pushNamed(context, AppRoutes.trafficMap);
        break;
      case 2:
        Navigator.pushNamed(context, AppRoutes.matatuTrack);
        break;
      case 3:
        Navigator.pushNamed(context, AppRoutes.flightSchedule);
        break;
      case 4:
        Navigator.pushNamed(context, AppRoutes.profile);
        break;
    }
  }
}

class _QuickAccessItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Color labelColor;
  final VoidCallback onTap;

  const _QuickAccessItem({
    required this.icon,
    required this.label,
    required this.color,
    required this.labelColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 56, height: 56,
            decoration: BoxDecoration(color: color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(16)),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 6),
          Text(label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: labelColor)),
        ],
      ),
    );
  }
}
