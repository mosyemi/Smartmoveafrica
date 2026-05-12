import '../models/flight_info.dart';

abstract class AirRepository {
  Future<List<FlightInfo>> fetchFlights();
  Future<AirportStatus> fetchAirportStatus();
}

class MockAirRepository implements AirRepository {
  @override
  Future<List<FlightInfo>> fetchFlights() async {
    final now = DateTime.now();
    return [
      FlightInfo(
        id: 'fl-1',
        airline: 'Kenya Airways',
        flightNumber: 'KQ 204',
        origin: 'NBO',
        destination: 'MBA',
        departureTime: now.add(const Duration(minutes: 35)),
        status: FlightStatus.boarding,
      ),
      FlightInfo(
        id: 'fl-2',
        airline: 'Jambojet',
        flightNumber: 'JM 871',
        origin: 'NBO',
        destination: 'KIS',
        departureTime: now.add(const Duration(hours: 1, minutes: 10)),
        status: FlightStatus.delayed,
      ),
      FlightInfo(
        id: 'fl-3',
        airline: 'Safarilink',
        flightNumber: 'F2 102',
        origin: 'WIL',
        destination: 'UKA',
        departureTime: now.add(const Duration(minutes: 50)),
        status: FlightStatus.onTime,
      ),
    ];
  }

  @override
  Future<AirportStatus> fetchAirportStatus() async {
    return const AirportStatus(
      airportCode: 'NBO',
      activeFlights: 32,
      delayedFlights: 4,
      airspaceCondition: 'Moderate congestion at departure corridors',
    );
  }
}
