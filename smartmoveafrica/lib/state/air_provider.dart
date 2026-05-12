import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/flight_info.dart';
import '../data/repositories/air_repository.dart';

final airRepositoryProvider = Provider<AirRepository>((ref) => MockAirRepository());

final flightsProvider = AsyncNotifierProvider<FlightsNotifier, List<FlightInfo>>(
  FlightsNotifier.new,
);

final airportStatusProvider = AsyncNotifierProvider<AirportStatusNotifier, AirportStatus>(
  AirportStatusNotifier.new,
);

class FlightsNotifier extends AsyncNotifier<List<FlightInfo>> {
  @override
  Future<List<FlightInfo>> build() async {
    return ref.read(airRepositoryProvider).fetchFlights();
  }
}

class AirportStatusNotifier extends AsyncNotifier<AirportStatus> {
  @override
  Future<AirportStatus> build() async {
    return ref.read(airRepositoryProvider).fetchAirportStatus();
  }
}
