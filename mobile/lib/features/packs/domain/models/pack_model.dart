import '../../products/domain/models/product_model.dart';

class PackItem {
  final String productId;
  final String productName;
  final int quantity;
  final double unitPrice;

  const PackItem({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.unitPrice,
  });

  factory PackItem.fromJson(Map<String, dynamic> json) {
    return PackItem(
      productId: json['productId'] as String? ?? '',
      productName: json['productName'] as String? ?? '',
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      unitPrice: (json['unitPrice'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'quantity': quantity,
      'unitPrice': unitPrice,
    };
  }
}

class PackModel {
  final String id;
  final String title;
  final String subtitle;
  final String tag; // e.g. "HOSTEL FAVORITE", "STUDY ESSENTIAL"
  final String imageUrl;
  final double price;
  final double originalPrice;
  final List<PackItem> items;

  const PackModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.tag,
    required this.imageUrl,
    required this.price,
    required this.originalPrice,
    required this.items,
  });

  double get discountPercentage =>
      originalPrice > price ? (((originalPrice - price) / originalPrice) * 100).roundToDouble() : 0.0;

  factory PackModel.fromJson(Map<String, dynamic> json) {
    return PackModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      subtitle: json['subtitle'] as String? ?? '',
      tag: json['tag'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      originalPrice: (json['originalPrice'] as num?)?.toDouble() ?? 0.0,
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => PackItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'tag': tag,
      'imageUrl': imageUrl,
      'price': price,
      'originalPrice': originalPrice,
      'items': items.map((e) => e.toJson()).toList(),
    };
  }
}
