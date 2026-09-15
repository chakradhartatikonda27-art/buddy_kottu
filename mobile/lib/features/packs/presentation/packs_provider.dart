import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/models/pack_model.dart';

final List<PackModel> mockPacksList = [
  const PackModel(
    id: 'pack_hostel_night',
    title: 'Hostel Night Pack',
    subtitle: 'Maggi + Chips + Coke + Chocolate',
    tag: 'HOSTEL FAVORITE',
    imageUrl: 'https://images.unsplash.com/photo-1612929633738-8fe44f7ec841?w=400',
    price: 139.0,
    originalPrice: 155.0,
    items: [
      PackItem(productId: 'p1', productName: 'Maggi 2-Min Masala', quantity: 2, unitPrice: 14.0),
      PackItem(productId: 'p9', productName: 'Lays Magic Masala 50g', quantity: 1, unitPrice: 20.0),
      PackItem(productId: 'p4', productName: 'Coca-Cola 750ml', quantity: 1, unitPrice: 40.0),
      PackItem(productId: 'p10', productName: 'Cadbury Dairy Milk 60g', quantity: 1, unitPrice: 75.0),
    ],
  ),
  const PackModel(
    id: 'pack_study',
    title: 'Study Pack',
    subtitle: 'Nescafe Coffee + Parle-G + Kinley Water',
    tag: 'LATE NIGHT STUDY',
    imageUrl: 'https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?w=400',
    price: 89.0,
    originalPrice: 98.0,
    items: [
      PackItem(productId: 'p8', productName: 'Parle-G Gold Biscuits', quantity: 2, unitPrice: 28.0),
      PackItem(productId: 'p6', productName: 'Kinley Water 1L', quantity: 1, unitPrice: 20.0),
    ],
  ),
  const PackModel(
    id: 'pack_hospital_visitor',
    title: 'Hospital Visitor Pack',
    subtitle: 'Kinley Water + Real Orange Juice + Parle-G',
    tag: 'HOSPITAL ESSENTIAL',
    imageUrl: 'https://images.unsplash.com/photo-1560023907-5f313d8750b7?w=400',
    price: 149.0,
    originalPrice: 165.0,
    items: [
      PackItem(productId: 'p6', productName: 'Kinley Water 1L', quantity: 2, unitPrice: 20.0),
      PackItem(productId: 'p7', productName: 'Real Orange Juice 1L', quantity: 1, unitPrice: 110.0),
      PackItem(productId: 'p8', productName: 'Parle-G Biscuits', quantity: 1, unitPrice: 28.0),
    ],
  ),
  const PackModel(
    id: 'pack_daily_essentials',
    title: 'Daily Essentials Pack',
    subtitle: 'Amul Milk + Bread + Eggs',
    tag: 'DAILY FRESH',
    imageUrl: 'https://images.unsplash.com/photo-1550583724-b2692b85b150?w=400',
    price: 109.0,
    originalPrice: 120.0,
    items: [
      PackItem(productId: 'p12', productName: 'Amul Taaza Milk 500ml', quantity: 2, unitPrice: 27.0),
    ],
  ),
];

final packsProvider = Provider<List<PackModel>>((ref) {
  return mockPacksList;
});
