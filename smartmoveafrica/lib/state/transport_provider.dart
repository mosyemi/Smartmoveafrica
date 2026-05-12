import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/matatu_vehicle.dart';
import '../data/repositories/transport_repository.dart';

final transportRepositoryProvider = Provider<TransportRepository>(
  (ref) => MockTransportRepository(),
);

final transportProvider = AsyncNotifierProvider<TransportNotifier, List<MatatuVehicle>>(
  TransportNotifier.new,
);

class TransportNotifier extends AsyncNotifier<List<MatatuVehicle>> {
  @override
  Future<List<MatatuVehicle>> build() async {
    return ref.read(transportRepositoryProvider).fetchVehicles();
  }

  double fareFor(MatatuVehicle vehicle) {
    return ref.read(transportRepositoryProvider).estimateFare(vehicle);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(transportRepositoryProvider).fetchVehicles());
  }
}
