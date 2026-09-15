import 'address_model.dart';
import '../../cart/domain/models/cart_item_model.dart';

enum OrderStatus {
  ORDER_RECEIVED,
  ACCEPTED,
  PREPARING,
  OUT_FOR_DELIVERY,
  DELIVERED,
  CANCELLED,
}

extension OrderStatusExtension on OrderStatus {
  String get label {
    switch (this) {
      case OrderStatus.ORDER_RECEIVED:
        return 'Order Placed';
      case OrderStatus.ACCEPTED:
        return 'Accepted by Store';
      case OrderStatus.PREPARING:
        return 'Packing Items';
      case OrderStatus.OUT_FOR_DELIVERY:
        return 'Out for Delivery';
      case OrderStatus.DELIVERED:
        return 'Delivered';
      case OrderStatus.CANCELLED:
        return 'Cancelled';
    }
  }

  int get stepIndex {
    switch (this) {
      case OrderStatus.ORDER_RECEIVED:
        return 0;
      case OrderStatus.ACCEPTED:
        return 1;
      case OrderStatus.PREPARING:
        return 2;
      case OrderStatus.OUT_FOR_DELIVERY:
        return 3;
      case OrderStatus.DELIVERED:
        return 4;
      case OrderStatus.CANCELLED:
        return -1;
    }
  }
}

class OrderModel {
  final String id;
  final String orderNumber;
  final String storeId;
  final String userId;
  final List<CartItemModel> items;
  final double subtotal;
  final double deliveryFee;
  final double discount;
  final double total;
  final String paymentMethod; // UPI, COD, Razorpay
  final String paymentStatus; // PENDING, PAID, FAILED
  final OrderStatus status;
  final AddressModel deliveryAddress;
  final String customerNotes;
  final DateTime createdAt;
  final DateTime? estimatedDeliveryTime;

  const OrderModel({
    required this.id,
    required this.orderNumber,
    required this.storeId,
    required this.userId,
    required this.items,
    required this.subtotal,
    required this.deliveryFee,
    required this.discount,
    required this.total,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.status,
    required this.deliveryAddress,
    required this.customerNotes,
    required this.createdAt,
    this.estimatedDeliveryTime,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] as String? ?? '',
      orderNumber: json['orderNumber'] as String? ?? 'BK-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
      storeId: json['storeId'] as String? ?? 'sri_siva_store_01',
      userId: json['userId'] as String? ?? '',
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => CartItemModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      subtotal: (json['subtotal'] as num?)?.toDouble() ?? 0.0,
      deliveryFee: (json['deliveryFee'] as num?)?.toDouble() ?? 0.0,
      discount: (json['discount'] as num?)?.toDouble() ?? 0.0,
      total: (json['total'] as num?)?.toDouble() ?? 0.0,
      paymentMethod: json['paymentMethod'] as String? ?? 'UPI',
      paymentStatus: json['paymentStatus'] as String? ?? 'PAID',
      status: OrderStatus.values.firstWhere(
        (e) => e.name == (json['orderStatus'] as String? ?? 'ORDER_RECEIVED'),
        orElse: () => OrderStatus.ORDER_RECEIVED,
      ),
      deliveryAddress: AddressModel.fromJson(json['deliveryAddress'] as Map<String, dynamic>? ?? {}),
      customerNotes: json['customerNotes'] as String? ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
      estimatedDeliveryTime: json['estimatedDeliveryTime'] != null
          ? DateTime.parse(json['estimatedDeliveryTime'] as String)
          : DateTime.now().add(const Duration(minutes: 15)),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderNumber': orderNumber,
      'storeId': storeId,
      'userId': userId,
      'items': items.map((e) => e.toJson()).toList(),
      'subtotal': subtotal,
      'deliveryFee': deliveryFee,
      'discount': discount,
      'total': total,
      'paymentMethod': paymentMethod,
      'paymentStatus': paymentStatus,
      'orderStatus': status.name,
      'deliveryAddress': deliveryAddress.toJson(),
      'customerNotes': customerNotes,
      'createdAt': createdAt.toIso8601String(),
      'estimatedDeliveryTime': estimatedDeliveryTime?.toIso8601String(),
    };
  }
}
