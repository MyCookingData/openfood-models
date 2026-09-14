class RestaurantModel {
  final String id;
  final String name;
  final String imageUrl;
  final double rating;
  final String status;
  final String type;
  final String zone;
  final double lat;
  final double lng;
  final String facebook;
  final String instagram;
  final String tiktok;
  final double? freeDeliveryThreshold;
  final String? stripeAccountId;

  RestaurantModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.rating = 5.0,
    this.status = 'actif',
    this.type = '',
    this.zone = '',
    this.lat = 0.0,
    this.lng = 0.0,
    this.facebook = '',
    this.instagram = '',
    this.tiktok = '',
    this.freeDeliveryThreshold,
    this.stripeAccountId,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'imageUrl': imageUrl,
    'rating': rating,
    'status': status,
    'type': type,
    'zone': zone,
    'lat': lat,
    'lng': lng,
    'facebook': facebook,
    'instagram': instagram,
    'tiktok': tiktok,
    'freeDeliveryThreshold': freeDeliveryThreshold,
    'stripeAccountId': stripeAccountId,
  };

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      id: json['id'] ?? '',
      name: json['name'] ?? 'Restaurant Inconnu',
      imageUrl: json['imageUrl'] ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 5.0,
      status: json['status'] ?? 'actif',
      type: json['type'] ?? '',
      zone: json['zone'] ?? '',
      lat: (json['lat'] as num?)?.toDouble() ?? 0.0,
      lng: (json['lng'] as num?)?.toDouble() ?? 0.0,
      facebook: json['facebook'] ?? '',
      instagram: json['instagram'] ?? '',
      tiktok: json['tiktok'] ?? '',
      freeDeliveryThreshold: (json['freeDeliveryThreshold'] as num?)?.toDouble(),
      stripeAccountId: json['stripeAccountId'],
    );
  }
}
