class DeliveryZoneModel {
  final String id;
  final String name;
  final double minRadiusKm;
  final double maxRadiusKm;
  final double baseFee;
  final double freeDeliveryThreshold;

  const DeliveryZoneModel({
    required this.id,
    required this.name,
    required this.minRadiusKm,
    required this.maxRadiusKm,
    required this.baseFee,
    required this.freeDeliveryThreshold,
  });
}

final List<DeliveryZoneModel> defaultDeliveryZonesList = [
  const DeliveryZoneModel(
    id: 'z1',
    name: 'GSL Hospital & Hostels Zone',
    minRadiusKm: 0.0,
    maxRadiusKm: 1.5,
    baseFee: 10.0,
    freeDeliveryThreshold: 149.0,
  ),
  const DeliveryZoneModel(
    id: 'z2',
    name: 'University & Colleges Zone',
    minRadiusKm: 1.5,
    maxRadiusKm: 3.0,
    baseFee: 20.0,
    freeDeliveryThreshold: 299.0,
  ),
  const DeliveryZoneModel(
    id: 'z3',
    name: 'Outer Residential Radius',
    minRadiusKm: 3.0,
    maxRadiusKm: 5.0,
    baseFee: 30.0,
    freeDeliveryThreshold: 399.0,
  ),
];
