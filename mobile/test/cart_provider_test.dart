import 'package:flutter_test/flutter_test.dart';
import 'package:buddy_kottu/features/cart/presentation/cart_provider.dart';
import 'package:buddy_kottu/features/products/domain/models/product_model.dart';

void main() {
  group('CartNotifier Unit Tests', () {
    late CartNotifier cartNotifier;

    const testProduct = ProductModel(
      id: 'p1',
      storeId: 'sri_siva_store_01',
      name: 'Maggi 2-Minute Masala Noodles 70g',
      nameNormalized: 'maggi 2-minute masala noodles 70g',
      brand: 'Nestle',
      brandNormalized: 'nestle',
      categoryId: 'c1',
      subcategoryId: 'noodles',
      description: 'Classic favorite instant noodles',
      price: 14.0,
      mrp: 15.0,
      discountPercentage: 7.0,
      imageUrl: 'https://example.com/maggi.png',
      thumbnailUrl: 'https://example.com/maggi.png',
      stock: 50,
      reservedStock: 0,
      availableStock: 50,
      unit: '70 g Pack',
      isAvailable: true,
      isFeatured: true,
      isNewArrival: false,
      isOffer: false,
      keywords: ['maggi', 'noodles'],
      searchTokens: ['maggi'],
    );

    setUp(() {
      cartNotifier = CartNotifier();
    });

    test('Initial cart state is empty', () {
      expect(cartNotifier.state.isEmpty, isTrue);
      expect(cartNotifier.state.totalItemCount, 0);
      expect(cartNotifier.state.subtotal, 0.0);
    });

    test('Add product increments item count and calculates subtotal', () {
      cartNotifier.addProduct(testProduct);

      expect(cartNotifier.state.items.length, 1);
      expect(cartNotifier.state.totalItemCount, 1);
      expect(cartNotifier.state.subtotal, 14.0);
    });

    test('Adding same product twice increments quantity to 2', () {
      cartNotifier.addProduct(testProduct);
      cartNotifier.addProduct(testProduct);

      expect(cartNotifier.state.items.length, 1);
      expect(cartNotifier.state.totalItemCount, 2);
      expect(cartNotifier.state.subtotal, 28.0);
    });

    test('Applying coupon code BUDDY10 applies 10% discount', () {
      cartNotifier.addProduct(testProduct);
      cartNotifier.addProduct(testProduct); // subtotal 28
      cartNotifier.applyCoupon('BUDDY10');

      expect(cartNotifier.state.couponDiscount, 2.8);
    });

    test('Clearing cart resets items and total to zero', () {
      cartNotifier.addProduct(testProduct);
      cartNotifier.clearCart();

      expect(cartNotifier.state.isEmpty, isTrue);
      expect(cartNotifier.state.subtotal, 0.0);
    });
  });
}
