class AddressModel {
  final String id;
  final String type; // 'Hostel', 'Hospital', 'Home', 'Other'
  final String title;
  final String fullAddress;
  final String blockOrRoom;
  final String landmark;
  final String recipientName;
  final String recipientPhone;
  final double? latitude;
  final double? longitude;
  final bool isDefault;

  const AddressModel({
    required this.id,
    required this.type,
    required this.title,
    required this.fullAddress,
    required this.blockOrRoom,
    required this.landmark,
    required this.recipientName,
    required this.recipientPhone,
    this.latitude,
    this.longitude,
    this.isDefault = false,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'] as String? ?? 'default_addr',
      type: json['type'] as String? ?? 'Hostel',
      title: json['title'] as String? ?? 'Hostel Block B',
      fullAddress: json['fullAddress'] as String? ?? 'GSL Medical College Hostel Campus, Rajahmundry',
      blockOrRoom: json['blockOrRoom'] as String? ?? 'Room 304, Block B',
      landmark: json['landmark'] as String? ?? 'Near Main Mess',
      recipientName: json['recipientName'] as String? ?? 'Rahul V',
      recipientPhone: json['recipientPhone'] as String? ?? '+91 9876543210',
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      isDefault: json['isDefault'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'title': title,
      'fullAddress': fullAddress,
      'blockOrRoom': blockOrRoom,
      'landmark': landmark,
      'recipientName': recipientName,
      'recipientPhone': recipientPhone,
      'latitude': latitude,
      'longitude': longitude,
      'isDefault': isDefault,
    };
  }
}
