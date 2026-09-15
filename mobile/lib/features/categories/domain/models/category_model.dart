class CategoryModel {
  final String id;
  final String name;
  final String icon;
  final String imageUrl;
  final int displayOrder;
  final bool isActive;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.imageUrl,
    required this.displayOrder,
    this.isActive = true,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      icon: json['icon'] as String? ?? 'box',
      imageUrl: json['imageUrl'] as String? ?? '',
      displayOrder: (json['displayOrder'] as num?)?.toInt() ?? 0,
      isActive: json['isActive'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'imageUrl': imageUrl,
      'displayOrder': displayOrder,
      'isActive': isActive,
    };
  }
}
