class CouponModel {
  final String id;
  final String code;
  final String title;
  final String description;
  final double discountAmount;
  final double discountPercentage;
  final double minOrderValue;
  final bool isPercentage;

  const CouponModel({
    required this.id,
    required this.code,
    required this.title,
    required this.description,
    required this.discountAmount,
    required this.discountPercentage,
    required this.minOrderValue,
    required this.isPercentage,
  });
}

final List<CouponModel> availableCouponsList = [
  const CouponModel(
    id: 'c_buddy50',
    code: 'BUDDY50',
    title: 'Flat ₹50 OFF',
    description: 'Flat ₹50 discount on orders above ₹299',
    discountAmount: 50.0,
    discountPercentage: 0.0,
    minOrderValue: 299.0,
    isPercentage: false,
  ),
  const CouponModel(
    id: 'c_hostel20',
    code: 'HOSTEL20',
    title: '20% Hostel Discount',
    description: '20% OFF on all hostel night packs & noodles',
    discountAmount: 0.0,
    discountPercentage: 20.0,
    minOrderValue: 149.0,
    isPercentage: true,
  ),
  const CouponModel(
    id: 'c_freedel',
    code: 'FREEDEL',
    title: 'Free Delivery',
    description: '100% Free delivery on any order above ₹149',
    discountAmount: 20.0,
    discountPercentage: 0.0,
    minOrderValue: 149.0,
    isPercentage: false,
  ),
  const CouponModel(
    id: 'c_gslcare',
    code: 'GSLCARE',
    title: '15% Hospital Staff Care',
    description: '15% discount for GSL Hospital staff & visitors',
    discountAmount: 0.0,
    discountPercentage: 15.0,
    minOrderValue: 199.0,
    isPercentage: true,
  ),
];
