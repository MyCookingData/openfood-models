class AddressModel {
  final String id;
  final String label; // "Domicile", "Bureau", etc.
  final String addressName;
  final double latitude;
  final double longitude;

  AddressModel({
    required this.id,
    required this.label,
    required this.addressName,
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'label': label,
    'addressName': addressName,
    'latitude': latitude,
    'longitude': longitude,
  };

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
    id: json['id'],
    label: json['label'],
    addressName: json['addressName'],
    latitude: json['latitude'],
    longitude: json['longitude'],
  );
}
