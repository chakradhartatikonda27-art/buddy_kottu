import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/models/order_model.dart';
import '../../cart/domain/models/cart_item_model.dart';
import '../../addresses/domain/address_model.dart';

class OrderState {
  final List<OrderModel> orders;
  final OrderModel? activeOrder;
  final bool isLoading;

  const OrderState({
    this.orders = const [],
    this.activeOrder,
    this.isLoading = false,
  });

  OrderState copyWith({
    List<OrderModel>? orders,
    OrderModel? activeOrder,
    bool? isLoading,
  }) {
    return OrderState(
      orders: orders ?? this.orders,
      activeOrder: activeOrder ?? this.activeOrder,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class OrderNotifier extends StateNotifier<OrderState> {
  OrderNotifier() : super(const OrderState());

  OrderModel createOrder({
    required List<CartItemModel> items,
    required double subtotal,
    required double deliveryFee,
    required double discount,
    required double total,
    required String paymentMethod,
    required AddressModel address,
    required String notes,
  }) {
    final now = DateTime.now();
    final newOrder = OrderModel(
      id: 'ord_${now.millisecondsSinceEpoch}',
      orderNumber: 'BK${now.millisecondsSinceEpoch.toString().substring(5)}',
      storeId: 'sri_siva_store_01',
      userId: 'usr_rahul_99',
      items: items,
      subtotal: subtotal,
      deliveryFee: deliveryFee,
      discount: discount,
      total: total,
      paymentMethod: paymentMethod,
      paymentStatus: paymentMethod == 'COD' ? 'PENDING' : 'PAID',
      status: OrderStatus.ORDER_RECEIVED,
      deliveryAddress: address,
      customerNotes: notes,
      createdAt: now,
      estimatedDeliveryTime: now.add(const Duration(minutes: 15)),
    );

    state = state.copyWith(
      orders: [newOrder, ...state.orders],
      activeOrder: newOrder,
    );

    return newOrder;
  }

  void updateOrderStatus(String orderId, OrderStatus newStatus) {
    final updatedList = state.orders.map((o) {
      if (o.id == orderId) {
        return OrderModel(
          id: o.id,
          orderNumber: o.orderNumber,
          storeId: o.storeId,
          userId: o.userId,
          items: o.items,
          subtotal: o.subtotal,
          deliveryFee: o.deliveryFee,
          discount: o.discount,
          total: o.total,
          paymentMethod: o.paymentMethod,
          paymentStatus: o.paymentStatus,
          status: newStatus,
          deliveryAddress: o.deliveryAddress,
          customerNotes: o.customerNotes,
          createdAt: o.createdAt,
          estimatedDeliveryTime: o.estimatedDeliveryTime,
        );
      }
      return o;
    }).toList();

    OrderModel? updatedActive = state.activeOrder;
    if (updatedActive != null && updatedActive.id == orderId) {
      updatedActive = updatedList.firstWhere((o) => o.id == orderId);
    }

    state = state.copyWith(
      orders: updatedList,
      activeOrder: updatedActive,
    );
  }
}

final orderProvider = StateNotifierProvider<OrderNotifier, OrderState>((ref) {
  return OrderNotifier();
});
