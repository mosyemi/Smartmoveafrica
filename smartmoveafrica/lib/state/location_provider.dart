import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/services/location_service.dart';

final locationServiceProvider = Provider<LocationService>((ref) => LocationService());

final locationProvider = AsyncNotifierProvider<LocationNotifier, LocationSnapshot>(
  LocationNotifier.new,
);

class LocationNotifier extends AsyncNotifier<LocationSnapshot> {
  @override
  Future<LocationSnapshot> build() async {
    return ref.read(locationServiceProvider).getCurrentLocation();
  }
}
