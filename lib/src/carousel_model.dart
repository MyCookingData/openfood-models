import 'package:cloud_firestore/cloud_firestore.dart';

enum CarouselActionType { none, open_restaurant, open_product, open_url, open_promo_code }
enum CarouselPlacement { home, restaurant }

class CarouselModel {
  final String id;
  final String emoji;
  final String title;
  final String subtitle;
  final String tagText;
  final String chipText;
  final List<String> gradientColorsHex;
  final String ctaText;
  final bool isSponsored;
  final String? imageUrl;
  final String? logoUrl;

  final CarouselActionType actionType;
  final String? actionPayload;
  final CarouselPlacement placement;

  final bool isActive;
  final int sortOrder;

  final List<int>? validDaysOfWeek;
  final String? validTimeStart;
  final String? validTimeEnd;

  final int? minOrders;
  final int? maxOrders;
  final double? minTotalSpent;
  final double? maxTotalSpent;
  final String? targetRestaurantId;

  CarouselModel({
    required this.id,
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.tagText,
    required this.chipText,
    required this.gradientColorsHex,
    required this.ctaText,
    this.isSponsored = false,
    this.imageUrl,
    this.logoUrl,
    this.actionType = CarouselActionType.none,
    this.actionPayload,
    this.placement = CarouselPlacement.home,
    this.isActive = true,
    this.sortOrder = 0,
    this.validDaysOfWeek,
    this.validTimeStart,
    this.validTimeEnd,
    this.minOrders,
    this.maxOrders,
    this.minTotalSpent,
    this.maxTotalSpent,
    this.targetRestaurantId,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'emoji': emoji,
        'title': title,
        'subtitle': subtitle,
        'tagText': tagText,
        'chipText': chipText,
        'gradientColorsHex': gradientColorsHex,
        'ctaText': ctaText,
        'isSponsored': isSponsored,
        'imageUrl': imageUrl,
        'logoUrl': logoUrl,
        'actionType': actionType.name,
        'actionPayload': actionPayload,
        'placement': placement.name,
        'isActive': isActive,
        'sortOrder': sortOrder,
        'validDaysOfWeek': validDaysOfWeek,
        'validTimeStart': validTimeStart,
        'validTimeEnd': validTimeEnd,
        'minOrders': minOrders,
        'maxOrders': maxOrders,
        'minTotalSpent': minTotalSpent,
        'maxTotalSpent': maxTotalSpent,
        'targetRestaurantId': targetRestaurantId,
      };

  factory CarouselModel.fromJson(Map<String, dynamic> json) {
    return CarouselModel(
      id: json['id'] ?? '',
      emoji: json['emoji'] ?? '👋',
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      tagText: json['tagText'] ?? '',
      chipText: json['chipText'] ?? '',
      gradientColorsHex: (json['gradientColorsHex'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          ['#1E8B3A', '#104A1F'],
      ctaText: json['ctaText'] ?? 'Découvrir',
      isSponsored: json['isSponsored'] ?? false,
      imageUrl: json['imageUrl'],
      logoUrl: json['logoUrl'],
      actionType: CarouselActionType.values.firstWhere(
        (e) => e.name == json['actionType'],
        orElse: () => CarouselActionType.none,
      ),
      actionPayload: json['actionPayload'],
      placement: CarouselPlacement.values.firstWhere(
        (e) => e.name == json['placement'],
        orElse: () => CarouselPlacement.home,
      ),
      isActive: json['isActive'] ?? true,
      sortOrder: json['sortOrder'] ?? 0,
      validDaysOfWeek: (json['validDaysOfWeek'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      validTimeStart: json['validTimeStart'],
      validTimeEnd: json['validTimeEnd'],
      minOrders: json['minOrders'],
      maxOrders: json['maxOrders'],
      minTotalSpent: (json['minTotalSpent'] as num?)?.toDouble(),
      maxTotalSpent: (json['maxTotalSpent'] as num?)?.toDouble(),
      targetRestaurantId: json['targetRestaurantId'],
    );
  }

  factory CarouselModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    data['id'] = doc.id;
    return CarouselModel.fromJson(data);
  }
}
