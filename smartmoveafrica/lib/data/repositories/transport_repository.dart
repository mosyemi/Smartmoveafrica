import '../models/matatu_vehicle.dart';

abstract class TransportRepository {
  Future<List<MatatuVehicle>> fetchVehicles();
  double estimateFare(MatatuVehicle vehicle);
}

class MockTransportRepository implements TransportRepository {
  @override
  Future<List<MatatuVehicle>> fetchVehicles() async {
    return const [
      MatatuVehicle(
        id: 'mt-1',
        routeName: 'CBD -> Rongai',
        plateNumber: 'KDG 294A',
        etaMinutes: 9,
        status: MatatuStatus.onTime,
        baseFareKes: 80,
        distanceKm: 13.5,
      ),
      MatatuVehicle(
        id: 'mt-2',
        routeName: 'Westlands -> CBD',
        plateNumber: 'KDN 449Y',
        etaMinutes: 14,
        status: MatatuStatus.delayed,
        baseFareKes: 60,
        distanceKm: 7.3,
      ),
      MatatuVehicle(
        id: 'mt-3',
        routeName: 'CBD -> Thika',
        plateNumber: 'KDL 824C',
        etaMinutes: 5,
        status: MatatuStatus.crowded,
        baseFareKes: 120,
        distanceKm: 18.2,
      ),
    ];
  }

  @override
  double estimateFare(MatatuVehicle vehicle) {
    final etaMultiplier = vehicle.etaMinutes > 10 ? 1.15 : 1.0;
    final demandMultiplier = switch (vehicle.status) {
      MatatuStatus.crowded => 1.2,
      MatatuStatus.delayed => 0.95,
      MatatuStatus.onTime => 1.0,
    };
    return vehicle.baseFareKes * etaMultiplier * demandMultiplier;
  }
}
