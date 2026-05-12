import 'package:permission_handler/permission_handler.dart';

class LocationSnapshot {
  final double latitude;
  final double longitude;
  final String areaLabel;

  const LocationSnapshot({
    required this.latitude,
    required this.longitude,
    required this.areaLabel,
  });
}

class LocationService {
  Future<LocationSnapshot> getCurrentLocation() async {
    final status = await Permission.locationWhenInUse.request();
    if (!status.isGranted) {
      return const LocationSnapshot(
        latitude: -1.286389,
        longitude: 36.817223,
        areaLabel: 'Location permission denied',
      );
    }
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return const LocationSnapshot(
      latitude: -1.286389,
      longitude: 36.817223,
      areaLabel: 'Nairobi CBD',
    );
  }
}
