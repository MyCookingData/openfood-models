class CategoryModel {
  final String id;
  final String name;
  final double defaultVatRate;
  final int order;

  CategoryModel({
    required this.id,
    required this.name,
    this.defaultVatRate = 2.1,
    this.order = 0,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'defaultVatRate': defaultVatRate,
    'order': order,
  };

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    id: json['id'] ?? '',
    name: json['name'] ?? '',
    defaultVatRate: (json['defaultVatRate'] as num?)?.toDouble() ?? 2.1,
    order: json['order'] ?? 0,
  );
}
