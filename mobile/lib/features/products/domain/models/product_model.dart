class ProductModel {
  final String id;
  final String storeId;
  final String name;
  final String nameNormalized;
  final String brand;
  final String brandNormalized;
  final String categoryId;
  final String subcategoryId;
  final String description;
  final double price;
  final double mrp;
  final double discountPercentage;
  final String imageUrl;
  final String thumbnailUrl;
  final int stock;
  final int reservedStock;
  final int availableStock;
  final String unit;
  final bool isAvailable;
  final bool isFeatured;
  final bool isNewArrival;
  final bool isOffer;
  final List<String> keywords;
  final List<String> searchTokens;

  const ProductModel({
    required this.id,
    required this.storeId,
    required this.name,
    required this.nameNormalized,
    required this.brand,
    required this.brandNormalized,
    required this.categoryId,
    required this.subcategoryId,
    required this.description,
    required this.price,
    required this.mrp,
    required this.discountPercentage,
    required this.imageUrl,
    required this.thumbnailUrl,
    required this.stock,
    required this.reservedStock,
    required this.availableStock,
    required this.unit,
    required this.isAvailable,
    required this.isFeatured,
    required this.isNewArrival,
    required this.isOffer,
    required this.keywords,
    required this.searchTokens,
  });

  bool get hasDiscount => discountPercentage > 0;
  bool get inStock => availableStock > 0 && isAvailable;

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final price = (json['price'] as num?)?.toDouble() ?? 0.0;
    final mrp = (json['mrp'] as num?)?.toDouble() ?? price;
    final discount = mrp > price ? (((mrp - price) / mrp) * 100).roundToDouble() : 0.0;

    return ProductModel(
      id: json['id'] as String? ?? '',
      storeId: json['storeId'] as String? ?? 'sri_siva_store_01',
      name: json['name'] as String? ?? '',
      nameNormalized: json['nameNormalized'] as String? ?? (json['name'] as String? ?? '').toLowerCase(),
      brand: json['brand'] as String? ?? '',
      brandNormalized: json['brandNormalized'] as String? ?? (json['brand'] as String? ?? '').toLowerCase(),
      categoryId: json['categoryId'] as String? ?? '',
      subcategoryId: json['subcategoryId'] as String? ?? '',
      description: json['description'] as String? ?? '',
      price: price,
      mrp: mrp,
      discountPercentage: (json['discountPercentage'] as num?)?.toDouble() ?? discount,
      imageUrl: json['imageUrl'] as String? ?? '',
      thumbnailUrl: json['thumbnailUrl'] as String? ?? json['imageUrl'] as String? ?? '',
      stock: (json['stock'] as num?)?.toInt() ?? 0,
      reservedStock: (json['reservedStock'] as num?)?.toInt() ?? 0,
      availableStock: (json['availableStock'] as num?)?.toInt() ?? (json['stock'] as num?)?.toInt() ?? 0,
      unit: json['unit'] as String? ?? '1 unit',
      isAvailable: json['isAvailable'] as bool? ?? true,
      isFeatured: json['isFeatured'] as bool? ?? false,
      isNewArrival: json['isNewArrival'] as bool? ?? false,
      isOffer: json['isOffer'] as bool? ?? false,
      keywords: (json['keywords'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      searchTokens: (json['searchTokens'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'storeId': storeId,
      'name': name,
      'nameNormalized': nameNormalized,
      'brand': brand,
      'brandNormalized': brandNormalized,
      'categoryId': categoryId,
      'subcategoryId': subcategoryId,
      'description': description,
      'price': price,
      'mrp': mrp,
      'discountPercentage': discountPercentage,
      'imageUrl': imageUrl,
      'thumbnailUrl': thumbnailUrl,
      'stock': stock,
      'reservedStock': reservedStock,
      'availableStock': availableStock,
      'unit': unit,
      'isAvailable': isAvailable,
      'isFeatured': isFeatured,
      'isNewArrival': isNewArrival,
      'isOffer': isOffer,
      'keywords': keywords,
      'searchTokens': searchTokens,
    };
  }
}
