import '../../products/domain/models/product_model.dart';

class CartItemModel {
  final ProductModel product;
  final int quantity;

  const CartItemModel({
    required this.product,
    required this.quantity,
  });

  double get itemTotal => product.price * quantity;
  double get itemMrpTotal => product.mrp * quantity;
  double get savings => itemMrpTotal - itemTotal;

  CartItemModel copyWith({
    ProductModel? product,
    int? quantity,
  }) {
    return CartItemModel(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      product: ProductModel.fromJson(json['product'] as Map<String, dynamic>),
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(),
      'quantity': quantity,
    };
  }
}
