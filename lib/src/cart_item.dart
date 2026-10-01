class CartItem {
  final String id;
  final String name;
  final double priceHT;
  final double vatRate;
  int quantity;
  final String category;
  final String restaurantId;
  final String? restaurantName;
  final String? image;
  final double? restaurantLat;
  final double? restaurantLng;
  final List<Map<String, dynamic>>? selectedOptions;

  CartItem({
    required this.id,
    required this.name,
    required this.priceHT,
    this.vatRate = 2.1,
    this.quantity = 1,
    required this.category,
    required this.restaurantId,
    this.restaurantName,
    this.image,
    this.restaurantLat,
    this.restaurantLng,
    this.selectedOptions,
  });

  /// Prix Unitaire TTC
  double get price => priceHT * (1 + vatRate / 100);

  /// Montant de TVA Unitaire
  double get vatAmount => priceHT * (vatRate / 100);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'priceHT': priceHT,
      'vatRate': vatRate,
      'quantity': quantity,
      'category': category,
      'restaurantId': restaurantId,
      'restaurantName': restaurantName,
      'image': image,
      'restaurantLat': restaurantLat,
      'restaurantLng': restaurantLng,
      'selectedOptions': selectedOptions,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    // Rétrocompatibilité du stockage existant
    final double ht = json['priceHT'] != null 
        ? json['priceHT'].toDouble() 
        : (json['price'] != null ? json['price'].toDouble() / 1.021 : 0.0);

    return CartItem(
      id: json['id'],
      name: json['name'],
      priceHT: ht,
      vatRate: json['vatRate'] != null ? json['vatRate'].toDouble() : 2.1,
      quantity: json['quantity'] ?? 1,
      category: json['category'] ?? '',
      restaurantId: json['restaurantId'] ?? '',
      restaurantName: json['restaurantName'],
      image: json['image'] ?? json['imageUrl'],
      restaurantLat: json['restaurantLat']?.toDouble(),
      restaurantLng: json['restaurantLng']?.toDouble(),
      selectedOptions: json['selectedOptions'] != null 
          ? List<Map<String, dynamic>>.from(json['selectedOptions'])
          : null,
    );
  }

  /// Calcule le sous-total TTC (prix TTC * quantité)
  double get subtotal => price * quantity;

  /// Calcule le sous-total HT (prix HT * quantité)
  double get subtotalHT => priceHT * quantity;

  /// Calcule le montant total de la TVA pour cette ligne
  double get totalVatAmount => vatAmount * quantity;
}
