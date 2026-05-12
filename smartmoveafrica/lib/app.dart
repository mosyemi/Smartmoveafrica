import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/constants/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'presentation/auth/screens/splash_screen.dart';
import 'presentation/auth/screens/onboarding_screen.dart';
import 'presentation/auth/screens/login_screen.dart';
import 'presentation/auth/screens/register_screen.dart';
import 'presentation/home/screens/home_screen.dart';
import 'presentation/home/screens/profile_screen.dart';
import 'presentation/home/screens/route_search_screen.dart';
import 'presentation/transport/screens/matatu_tracking_screen.dart';
import 'presentation/air/screens/flight_schedule_screen.dart';
import 'presentation/air/screens/airport_monitor_screen.dart';
import 'presentation/traffic/screens/report_incident_screen.dart';
import 'presentation/traffic/screens/traffic_map_screen.dart';
import 'state/theme_mode_provider.dart';

class SmartMoveApp extends ConsumerWidget {
  const SmartMoveApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appThemeMode = ref.watch(themeModeProvider);
    return MaterialApp(
      title: 'SmartMoveAfrica',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: appThemeMode.themeMode,
      initialRoute: AppRoutes.splash,
      routes: {
        AppRoutes.splash:      (_) => const SplashScreen(),
        AppRoutes.onboarding:  (_) => const OnboardingScreen(),
        AppRoutes.login:       (_) => const LoginScreen(),
        AppRoutes.register:    (_) => const RegisterScreen(),
        AppRoutes.home:        (_) => const HomeScreen(),
        AppRoutes.trafficMap: (_) => const TrafficMapScreen(),
        AppRoutes.reportIncident: (_) => const ReportIncidentScreen(),
        AppRoutes.matatuTrack: (_) => const MatatuTrackingScreen(),
        AppRoutes.flightSchedule: (_) => const FlightScheduleScreen(),
        AppRoutes.routeSearch: (_) => const RouteSearchScreen(),
        AppRoutes.airportMonitor: (_) => const AirportMonitorScreen(),
        AppRoutes.profile: (_) => const ProfileScreen(),
      },
    );
  }
}
