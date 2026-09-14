class UserModel {
  final String id;
  final String email;
  final String name;
  final String role; // "admin", "restaurant_owner", "customer", "livreur"
  final String? restaurantId;
  final String? phone;
  final DateTime createdAt;
  final bool isActive;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.role,
    this.restaurantId,
    this.phone,
    required this.createdAt,
    this.isActive = true,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'name': name,
    'role': role,
    'restaurantId': restaurantId,
    'phone': phone,
    'createdAt': createdAt.toIso8601String(),
    'isActive': isActive,
  };

  factory UserModel.fromJson(Map<String, dynamic> json) {
    DateTime parsedDate = DateTime.now();
    if (json['createdAt'] != null) {
      if (json['createdAt'] is String) {
        parsedDate = DateTime.tryParse(json['createdAt']) ?? DateTime.now();
      } else if (json['createdAt'].runtimeType.toString() == 'Timestamp') {
        // Handle Firestore Timestamp if passed directly as json output
        parsedDate = json['createdAt'].toDate();
      }
    }

    return UserModel(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      role: json['role'] ?? 'customer',
      restaurantId: json['restaurantId'],
      phone: json['phone'],
      createdAt: parsedDate,
      isActive: json['isActive'] ?? true,
    );
  }
}
