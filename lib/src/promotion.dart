enum PromotionType { percentage, fixed }
enum PromoTarget { cart_subtotal, selected_products, most_expensive, least_expensive, delivery_fee }

class PromoCodeModel {
  final String id;
  final String code;
  final PromotionType type;
  final double value;
  final bool isActive;
  final bool isGlobal;
  final int? maxUses;
  final int currentUses;
  final int? maxUsesPerUser;
  final bool firstOrderOnly;
  final List<int>? validDaysOfWeek;
  final String? validTimeStart;
  final String? validTimeEnd;
  final String? successMessage;
  final DateTime? expirationDate;
  final double? minAmount;
  final int? minQuantity;
  final String? requiredRestaurantId;
  final List<String>? applicableProductIds;
  final PromoTarget discountTarget;
  final String? batchId;
  final DateTime createdAt;

  PromoCodeModel({
    required this.id,
    required this.code,
    required this.type,
    required this.value,
    this.isActive = true,
    this.isGlobal = true,
    this.maxUses,
    this.currentUses = 0,
    this.maxUsesPerUser,
    this.firstOrderOnly = false,
    this.validDaysOfWeek,
    this.validTimeStart,
    this.validTimeEnd,
    this.successMessage,
    this.expirationDate,
    this.minAmount,
    this.minQuantity,
    this.requiredRestaurantId,
    this.applicableProductIds,
    this.discountTarget = PromoTarget.cart_subtotal,
    this.batchId,
    DateTime? createdAt,
  }) : this.createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toJson() => {
    'id': id,
    'code': code,
    'type': type.name,
    'value': value,
    'isActive': isActive,
    'isGlobal': isGlobal,
    'maxUses': maxUses,
    'currentUses': currentUses,
    'maxUsesPerUser': maxUsesPerUser,
    'firstOrderOnly': firstOrderOnly,
    'validDaysOfWeek': validDaysOfWeek,
    'validTimeStart': validTimeStart,
    'validTimeEnd': validTimeEnd,
    'successMessage': successMessage,
    'expirationDate': expirationDate?.toIso8601String(),
    'minAmount': minAmount,
    'minQuantity': minQuantity,
    'requiredRestaurantId': requiredRestaurantId,
    'applicableProductIds': applicableProductIds,
    'discountTarget': discountTarget.name,
    'batchId': batchId,
    'createdAt': createdAt.toIso8601String(),
  };

  factory PromoCodeModel.fromJson(Map<String, dynamic> json) {
    return PromoCodeModel(
      id: json['id'] ?? '',
      code: json['code'] ?? '',
      type: PromotionType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => PromotionType.fixed,
      ),
      value: (json['value'] as num?)?.toDouble() ?? 0.0,
      isActive: json['isActive'] ?? true,
      isGlobal: json['isGlobal'] ?? true,
      maxUses: json['maxUses'],
      currentUses: json['currentUses'] ?? 0,
      maxUsesPerUser: json['maxUsesPerUser'],
      firstOrderOnly: json['firstOrderOnly'] ?? false,
      validDaysOfWeek: (json['validDaysOfWeek'] as List<dynamic>?)?.map((e) => e as int).toList(),
      validTimeStart: json['validTimeStart'],
      validTimeEnd: json['validTimeEnd'],
      successMessage: json['successMessage'],
      expirationDate: json['expirationDate'] != null
          ? DateTime.tryParse(json['expirationDate'])
          : null,
      minAmount: (json['minAmount'] as num?)?.toDouble(),
      minQuantity: json['minQuantity'] as int?,
      requiredRestaurantId: json['requiredRestaurantId'],
      applicableProductIds: (json['applicableProductIds'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      discountTarget: PromoTarget.values.firstWhere(
        (e) => e.name == json['discountTarget'],
        orElse: () => PromoTarget.cart_subtotal,
      ),
      batchId: json['batchId'],
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt']) ?? DateTime.now()
          : DateTime.now(),
    );
  }

  bool isValid() {
    if (!isActive) return false;
    if (expirationDate != null && expirationDate!.isBefore(DateTime.now())) {
      return false;
    }
    if (maxUses != null && currentUses >= maxUses!) return false;
    return true;
  }
}
