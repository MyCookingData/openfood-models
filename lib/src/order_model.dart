import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String id;
  final String userId;
  final String restaurantId;
  final String restaurantName;
  final int status; // 0: Attente, 1: Préparation, 2: Route, 3: Livré, 4: Annulé
  final double totalAmount;
  final List<Map<String, dynamic>> items;
  final DateTime createdAt;
  final String? deliveryAddress;
  final String? customerName;
  final String? customerPhone;
  final DateTime? deliveredAt;
  final double? customerLat;
  final double? customerLng;
  final String? driverId;
  final String? driverName;
  final String? driverPhone;
  final int? prepTimeMinutes;
  final String? stripePaymentIntentId;
  final String? promoCodeId;
  final double? discountAmount;
  final String? paymentStatus;

  OrderModel({
    required this.id,
    required this.userId,
    required this.restaurantId,
    required this.restaurantName,
    required this.status,
    required this.totalAmount,
    required this.items,
    required this.createdAt,
    this.deliveryAddress,
    this.customerName,
    this.customerPhone,
    this.deliveredAt,
    this.customerLat,
    this.customerLng,
    this.driverId,
    this.driverName,
    this.driverPhone,
    this.prepTimeMinutes,
    this.stripePaymentIntentId,
    this.promoCodeId,
    this.discountAmount,
    this.paymentStatus,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'restaurantId': restaurantId,
      'restaurantName': restaurantName,
      'status': status,
      'totalAmount': totalAmount,
      'items': items,
      'createdAt': Timestamp.fromDate(createdAt),
      'deliveryAddress': deliveryAddress,
      'customerName': customerName,
      'customerPhone': customerPhone,
      'deliveredAt': deliveredAt != null ? Timestamp.fromDate(deliveredAt!) : null,
      'customerLat': customerLat,
      'customerLng': customerLng,
      'driverId': driverId,
      'driverName': driverName,
      'driverPhone': driverPhone,
      'prepTimeMinutes': prepTimeMinutes,
      'stripePaymentIntentId': stripePaymentIntentId,
      'promoCodeId': promoCodeId,
      'discountAmount': discountAmount,
      'paymentStatus': paymentStatus,
    };
  }

  factory OrderModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return OrderModel(
      id: doc.id,
      userId: data['userId'] ?? '',
      restaurantId: data['restaurantId'] ?? '',
      restaurantName: data['restaurantName'] ?? 'Restaurant Inconnu',
      status: data['status'] ?? 0,
      totalAmount: (data['totalAmount'] ?? 0).toDouble(),
      items: List<Map<String, dynamic>>.from(data['items'] ?? []),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      deliveryAddress: data['deliveryAddress'],
      customerName: data['customerName'],
      customerPhone: data['customerPhone'],
      deliveredAt: data['deliveredAt'] != null ? (data['deliveredAt'] as Timestamp).toDate() : null,
      customerLat: (data['customerLat'] as num?)?.toDouble(),
      customerLng: (data['customerLng'] as num?)?.toDouble(),
      driverId: data['driverId'],
      driverName: data['driverName'],
      driverPhone: data['driverPhone'],
      prepTimeMinutes: data['prepTimeMinutes'] as int?,
      stripePaymentIntentId: data['stripePaymentIntentId'],
      promoCodeId: data['promoCodeId'],
      discountAmount: (data['discountAmount'] as num?)?.toDouble(),
      paymentStatus: data['paymentStatus'],
    );
  }
}
