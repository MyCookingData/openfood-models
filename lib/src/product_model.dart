class ProductModifierOption {
  String id;
  String name;
  String? linkedInventoryItemId;
  double extraPrice;
  bool isAvailable;

  ProductModifierOption({
    required this.id,
    required this.name,
    this.linkedInventoryItemId,
    this.extraPrice = 0.0,
    this.isAvailable = true,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'linkedInventoryItemId': linkedInventoryItemId,
    'extraPrice': extraPrice,
    'isAvailable': isAvailable,
  };

  factory ProductModifierOption.fromJson(Map<String, dynamic> json) => ProductModifierOption(
    id: json['id'] ?? '',
    name: json['name'] ?? '',
    linkedInventoryItemId: json['linkedInventoryItemId'],
    extraPrice: (json['extraPrice'] as num?)?.toDouble() ?? 0.0,
    isAvailable: json['isAvailable'] ?? true,
  );
}

class ProductModifierGroup {
  String id;
  String name; // e.g. "Choix de la boisson"
  int minSelections;
  int maxSelections;
  List<ProductModifierOption> options;

  ProductModifierGroup({
    required this.id,
    required this.name,
    this.minSelections = 1,
    this.maxSelections = 1,
    this.options = const [],
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'minSelections': minSelections,
    'maxSelections': maxSelections,
    'options': options.map((e) => e.toJson()).toList(),
  };

  factory ProductModifierGroup.fromJson(Map<String, dynamic> json) => ProductModifierGroup(
    id: json['id'] ?? '',
    name: json['name'] ?? '',
    minSelections: json['minSelections'] ?? 1,
    maxSelections: json['maxSelections'] ?? 1,
    options: (json['options'] as List<dynamic>?)
            ?.map((e) => ProductModifierOption.fromJson(Map<String, dynamic>.from(e as Map)))
            .toList() ??
        [],
  );
}

class ProductModel {
  final String id;
  final String restaurantId;
  final String? restaurantName;
  final String category;
  final String name;
  final String description;
  final String image;
  final double priceHT;
  final double vatRate;
  final String badgeText;
  
  // Nouveautés pour la gestion des stocks
  final bool isAvailable; 
  final String? linkedInventoryItemId; // Si le produit entier dépend d'un seul item (ex: Coca Cola)
  final List<ProductModifierGroup> modifierGroups; // Les options pour les menus

  ProductModel({
    required this.id,
    required this.restaurantId,
    this.restaurantName,
    required this.category,
    required this.name,
    required this.description,
    required this.image,
    required this.priceHT,
    this.vatRate = 2.1,
    this.badgeText = "",
    this.isAvailable = true,
    this.linkedInventoryItemId,
    this.modifierGroups = const [],
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'restaurantId': restaurantId,
    'restaurantName': restaurantName,
    'category': category,
    'name': name,
    'description': description,
    'image': image,
    'priceHT': priceHT,
    'vatRate': vatRate,
    'badgeText': badgeText,
    'isAvailable': isAvailable,
    'linkedInventoryItemId': linkedInventoryItemId,
    'modifierGroups': modifierGroups.map((e) => e.toJson()).toList(),
  };

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    List<ProductModifierGroup> mGroups = (json['modifierGroups'] as List<dynamic>?)
            ?.map((e) => ProductModifierGroup.fromJson(Map<String, dynamic>.from(e as Map)))
            .toList() ?? [];

    if (mGroups.isEmpty && json['optionsTree'] != null) {
      final tree = json['optionsTree'] as List<dynamic>;
      mGroups = tree.map((g) {
        final groupData = Map<String, dynamic>.from(g as Map);
        final title = groupData['title']?.toString() ?? 'Groupe';
        final isRequired = groupData['required'] == true;
        final maxSelections = groupData['max'] as int? ?? 1;
        final choices = (groupData['choices'] as List<dynamic>?) ?? [];
        
        return ProductModifierGroup(
          id: groupData['id']?.toString() ?? DateTime.now().millisecondsSinceEpoch.toString(),
          name: title,
          minSelections: isRequired ? 1 : 0,
          maxSelections: maxSelections,
          options: choices.map((c) {
            final cData = Map<String, dynamic>.from(c as Map);
            return ProductModifierOption(
              id: cData['id']?.toString() ?? DateTime.now().millisecondsSinceEpoch.toString(),
              name: cData['name']?.toString() ?? 'Option',
              extraPrice: (cData['extraPrice'] as num?)?.toDouble() ?? 0.0,
            );
          }).toList(),
        );
      }).toList();
    }

    return ProductModel(
      id: json['id'] ?? '',
      restaurantId: json['restaurantId'] ?? '',
      restaurantName: json['restaurantName'],
      category: json['category'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      priceHT: (json['priceHT'] as num?)?.toDouble() ?? 0.0,
      vatRate: (json['vatRate'] as num?)?.toDouble() ?? 2.1,
      badgeText: json['badgeText'] ?? '',
      isAvailable: json['isAvailable'] ?? true,
      linkedInventoryItemId: json['linkedInventoryItemId'],
      modifierGroups: mGroups,
    );
  }
}
