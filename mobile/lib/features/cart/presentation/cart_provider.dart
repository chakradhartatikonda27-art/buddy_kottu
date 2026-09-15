import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/models/cart_item_model.dart';
import '../../products/domain/models/product_model.dart';
import '../../packs/domain/models/pack_model.dart';

class CartState {
  final List<CartItemModel> items;
  final String? appliedCouponCode;
  final double couponDiscount;

  const CartState({
    this.items = const [],
    this.appliedCouponCode,
    this.couponDiscount = 0.0,
  });

  int get totalItemCount => items.fold(0, (sum, item) => sum + item.quantity);

  double get subtotal => items.fold(0.0, (sum, item) => sum + item.itemTotal);

  double get mrpSubtotal => items.fold(0.0, (sum, item) => sum + item.itemMrpTotal);

  double get productSavings => mrpSubtotal - subtotal;

  double get deliveryFee => subtotal >= 299 || items.isEmpty ? 0.0 : 20.0;

  double get grandTotal => (subtotal + deliveryFee - couponDiscount).clamp(0.0, 999999.0);

  bool get isEmpty => items.isEmpty;
  bool get isNotEmpty => items.isNotEmpty;

  CartState copyWith({
    List<CartItemModel>? items,
    String? appliedCouponCode,
    double? couponDiscount,
  }) {
    return CartState(
      items: items ?? this.items,
      appliedCouponCode: appliedCouponCode ?? this.appliedCouponCode,
      couponDiscount: couponDiscount ?? this.couponDiscount,
    );
  }
}

class CartNotifier extends StateNotifier<CartState> {
  CartNotifier() : super(const CartState());

  void addProduct(ProductModel product) {
    final existingIndex = state.items.indexWhere((item) => item.product.id == product.id);

    if (existingIndex >= 0) {
      final updatedList = List<CartItemModel>.from(state.items);
      final currentQuantity = updatedList[existingIndex].quantity;
      updatedList[existingIndex] = updatedList[existingIndex].copyWith(
        quantity: currentQuantity + 1,
      );
      state = state.copyWith(items: updatedList);
    } else {
      state = state.copyWith(
        items: [...state.items, CartItemModel(product: product, quantity: 1)],
      );
    }
  }

  void updateQuantity(String productId, int quantity) {
    if (quantity <= 0) {
      removeProduct(productId);
      return;
    }

    final updatedList = state.items.map((item) {
      if (item.product.id == productId) {
        return item.copyWith(quantity: quantity);
      }
      return item;
    }).toList();

    state = state.copyWith(items: updatedList);
  }

  void removeProduct(String productId) {
    state = state.copyWith(
      items: state.items.where((item) => item.product.id != productId).toList(),
    );
  }

  void addPack(PackModel pack) {
    final updatedList = List<CartItemModel>.from(state.items);

    for (final packItem in pack.items) {
      final dummyProduct = ProductModel(
        id: packItem.productId,
        storeId: 'sri_siva_store_01',
        name: packItem.productName,
        nameNormalized: packItem.productName.toLowerCase(),
        brand: 'Buddy Pack',
        brandNormalized: 'buddy pack',
        categoryId: 'packs',
        subcategoryId: '',
        description: 'Part of ${pack.title}',
        price: packItem.unitPrice,
        mrp: packItem.unitPrice * 1.15,
        discountPercentage: 15.0,
        imageUrl: pack.imageUrl,
        thumbnailUrl: pack.imageUrl,
        stock: 50,
        reservedStock: 0,
        availableStock: 50,
        unit: '1 unit',
        isAvailable: true,
        isFeatured: true,
        isNewArrival: false,
        isOffer: true,
        keywords: ['pack', 'combo'],
        searchTokens: ['pack', 'combo'],
      );

      final index = updatedList.indexWhere((item) => item.product.id == packItem.productId);
      if (index >= 0) {
        updatedList[index] = updatedList[index].copyWith(
          quantity: updatedList[index].quantity + packItem.quantity,
        );
      } else {
        updatedList.add(CartItemModel(product: dummyProduct, quantity: packItem.quantity));
      }
    }

    state = state.copyWith(items: updatedList);
  }

  void applyCoupon(String code) {
    if (code.toUpperCase() == 'BUDDY10') {
      final discountAmount = (state.subtotal * 0.10).clamp(0.0, 50.0);
      state = state.copyWith(
        appliedCouponCode: 'BUDDY10',
        couponDiscount: discountAmount,
      );
    } else if (code.toUpperCase() == 'HOSTEL20') {
      state = state.copyWith(
        appliedCouponCode: 'HOSTEL20',
        couponDiscount: 20.0,
      );
    }
  }

  void clearCart() {
    state = const CartState();
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, CartState>((ref) {
  return CartNotifier();
});
