import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../cart_provider.dart';
import '../../../../core/constants/app_colors.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  final TextEditingController _couponController = TextEditingController();

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartState = ref.watch(cartProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart (${cartState.totalItemCount} Items)'),
        actions: [
          if (cartState.isNotEmpty)
            TextButton(
              onPressed: () {
                ref.read(cartProvider.notifier).clearCart();
              },
              child: const Text('Clear', style: TextStyle(color: AppColors.error)),
            ),
        ],
      ),
      body: SafeArea(
        child: cartState.isEmpty
            ? _buildEmptyCart(context)
            : Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Free delivery progress banner
                          _buildFreeDeliveryProgress(cartState),
                          const SizedBox(height: 16),

                          // Cart Items List
                          ...cartState.items.map((item) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surface,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Theme.of(context).brightness == Brightness.dark
                                      ? AppColors.darkCardBorder
                                      : AppColors.cardBorder,
                                ),
                              ),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      item.product.imageUrl,
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) =>
                                          Container(width: 60, height: 60, color: Colors.grey.shade300),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.product.name,
                                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                                          maxLines: 2,
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          '₹${item.product.price.toStringAsFixed(0)} / ${item.product.unit}',
                                          style: const TextStyle(color: AppColors.textMuted, fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Quantity Stepper
                                  Container(
                                    height: 32,
                                    decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          icon: const Icon(LucideIcons.minus, size: 14, color: Colors.white),
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(minWidth: 26, minHeight: 32),
                                          onPressed: () {
                                            ref.read(cartProvider.notifier).updateQuantity(
                                                  item.product.id,
                                                  item.quantity - 1,
                                                );
                                          },
                                        ),
                                        Text(
                                          '${item.quantity}',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        IconButton(
                                          icon: const Icon(LucideIcons.plus, size: 14, color: Colors.white),
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(minWidth: 26, minHeight: 32),
                                          onPressed: () {
                                            ref.read(cartProvider.notifier).updateQuantity(
                                                  item.product.id,
                                                  item.quantity + 1,
                                                );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                          const SizedBox(height: 16),

                          // Coupon Code Box
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: AppColors.cardBorder),
                            ),
                            child: Row(
                              children: [
                                const Icon(LucideIcons.ticket, color: AppColors.accent, size: 20),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: TextField(
                                    controller: _couponController,
                                    decoration: const InputDecoration(
                                      hintText: 'Enter coupon (e.g. BUDDY10)',
                                      hintStyle: TextStyle(fontSize: 12, color: AppColors.textMuted),
                                      border: InputBorder.none,
                                    ),
                                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    ref.read(cartProvider.notifier).applyCoupon(_couponController.text);
                                  },
                                  child: const Text('APPLY', style: TextStyle(fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Bill Summary Card
                          _buildBillSummary(context, cartState),
                        ],
                      ),
                    ),
                  ),

                  // Bottom Proceed Button
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -4)),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () => context.push('/checkout'),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'TOTAL  ₹${cartState.grandTotal.toStringAsFixed(0)}',
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                              ),
                              if (cartState.productSavings > 0)
                                Text(
                                  'Savings ₹${cartState.productSavings.toStringAsFixed(0)}',
                                  style: const TextStyle(fontSize: 10, color: Colors.white70),
                                ),
                            ],
                          ),
                          Row(
                            children: const [
                              Text('PROCEED TO CHECKOUT', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800)),
                              SizedBox(width: 4),
                              Icon(LucideIcons.arrowRight, size: 18),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildEmptyCart(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: AppColors.primaryLight,
                shape: BoxShape.circle,
              ),
              child: const Icon(LucideIcons.shoppingCart, color: AppColors.primary, size: 48),
            ),
            const SizedBox(height: 20),
            Text(
              'Your cart is empty',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Add snacks, drinks, or hostel essentials to get started.',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.textMuted, fontSize: 13),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: const Text('EXPLORE CATALOG'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFreeDeliveryProgress(CartState cartState) {
    final remaining = 299.0 - cartState.subtotal;
    final isFree = remaining <= 0;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isFree ? AppColors.primaryLight : AppColors.accentLight,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(
            isFree ? LucideIcons.truck : LucideIcons.info,
            color: isFree ? AppColors.primary : AppColors.accent,
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              isFree
                  ? '🎉 You unlocked FREE Delivery!'
                  : 'Add ₹${remaining.toStringAsFixed(0)} more for FREE Delivery',
              style: TextStyle(
                color: isFree ? AppColors.primary : AppColors.accent,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBillSummary(BuildContext context, CartState cartState) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Theme.of(context).brightness == Brightness.dark
              ? AppColors.darkCardBorder
              : AppColors.cardBorder,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'BILL DETAILS',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, letterSpacing: 0.5),
          ),
          const SizedBox(height: 12),
          _billRow('Items Subtotal', '₹${cartState.subtotal.toStringAsFixed(0)}'),
          _billRow('Delivery Fee', cartState.deliveryFee == 0 ? 'FREE' : '₹${cartState.deliveryFee.toStringAsFixed(0)}'),
          if (cartState.couponDiscount > 0)
            _billRow('Coupon Discount', '-₹${cartState.couponDiscount.toStringAsFixed(0)}', isDiscount: true),
          const Divider(height: 20),
          _billRow('To Pay', '₹${cartState.grandTotal.toStringAsFixed(0)}', isBold: true),
        ],
      ),
    );
  }

  Widget _billRow(String label, String value, {bool isDiscount = false, bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 13, fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
          Text(
            value,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
              color: isDiscount ? AppColors.primary : null,
            ),
          ),
        ],
      ),
    );
  }
}
