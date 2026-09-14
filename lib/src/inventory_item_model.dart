class InventoryItemModel {
  final String id;
  final String restaurantId;
  final String name;
  final bool isAvailable;
  final int? stockCount; // Optional explicit stock count

  InventoryItemModel({
    required this.id,
    required this.restaurantId,
    required this.name,
    this.isAvailable = true,
    this.stockCount,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'restaurantId': restaurantId,
    'name': name,
    'isAvailable': isAvailable,
    'stockCount': stockCount,
  };

  factory InventoryItemModel.fromJson(Map<String, dynamic> json) => InventoryItemModel(
    id: json['id'] ?? '',
    restaurantId: json['restaurantId'] ?? '',
    name: json['name'] ?? '',
    isAvailable: json['isAvailable'] ?? true,
    stockCount: json['stockCount'],
  );
}
