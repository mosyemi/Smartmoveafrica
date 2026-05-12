enum MatatuStatus { onTime, delayed, crowded }

class MatatuVehicle {
  final String id;
  final String routeName;
  final String plateNumber;
  final int etaMinutes;
  final MatatuStatus status;
  final double baseFareKes;
  final double distanceKm;

  const MatatuVehicle({
    required this.id,
    required this.routeName,
    required this.plateNumber,
    required this.etaMinutes,
    required this.status,
    required this.baseFareKes,
    required this.distanceKm,
  });
}
