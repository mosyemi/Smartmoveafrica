import 'package:flutter_test/flutter_test.dart';
import 'package:smartmoveafrica/data/models/matatu_vehicle.dart';
import 'package:smartmoveafrica/data/repositories/transport_repository.dart';

void main() {
  test('fare estimation increases when vehicle is crowded', () {
    final repository = MockTransportRepository();
    const vehicle = MatatuVehicle(
      id: 'x',
      routeName: 'CBD -> Rongai',
      plateNumber: 'KDK123A',
      etaMinutes: 8,
      status: MatatuStatus.crowded,
      baseFareKes: 100,
      distanceKm: 12,
    );
    final fare = repository.estimateFare(vehicle);
    expect(fare, greaterThan(100));
  });
}
