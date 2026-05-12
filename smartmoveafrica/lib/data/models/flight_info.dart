enum FlightStatus { onTime, delayed, boarding, departed }

class FlightInfo {
  final String id;
  final String airline;
  final String flightNumber;
  final String origin;
  final String destination;
  final DateTime departureTime;
  final FlightStatus status;

  const FlightInfo({
    required this.id,
    required this.airline,
    required this.flightNumber,
    required this.origin,
    required this.destination,
    required this.departureTime,
    required this.status,
  });
}

class AirportStatus {
  final String airportCode;
  final int activeFlights;
  final int delayedFlights;
  final String airspaceCondition;

  const AirportStatus({
    required this.airportCode,
    required this.activeFlights,
    required this.delayedFlights,
    required this.airspaceCondition,
  });
}
