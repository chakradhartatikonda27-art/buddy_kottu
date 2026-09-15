import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../order_provider.dart';
import '../domain/models/order_model.dart';
import '../../../cart/presentation/cart_provider.dart';
import '../../../../core/constants/app_colors.dart';

class OrdersScreen extends ConsumerWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderState = ref.watch(orderProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
      ),
      body: SafeArea(
        child: orderState.orders.isEmpty
            ? _buildEmptyOrders(context)
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: orderState.orders.length,
                itemBuilder: (context, index) {
                  final order = orderState.orders[index];
                  return _buildOrderCard(context, ref, order);
                },
              ),
      ),
    );
  }

  Widget _buildEmptyOrders(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: AppColors.primaryLight,
                shape: BoxShape.circle,
              ),
              child: const Icon(LucideIcons.shoppingBag, color: AppColors.primary, size: 40),
            ),
            const SizedBox(height: 16),
            Text(
              'No orders yet',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Place your first order to get items delivered in 15 minutes!',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.textMuted, fontSize: 13),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: const Text('START SHOPPING'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderCard(BuildContext context, WidgetRef ref, OrderModel order) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                order.orderNumber,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: order.status == OrderStatus.DELIVERED
                      ? AppColors.primaryLight
                      : AppColors.accentLight,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  order.status.label.toUpperCase(),
                  style: TextStyle(
                    color: order.status == OrderStatus.DELIVERED
                        ? AppColors.primary
                        : AppColors.accent,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            '${order.items.length} items • ₹${order.total.toStringAsFixed(0)} • ${order.paymentMethod}',
            style: const TextStyle(color: AppColors.textMuted, fontSize: 13),
          ),
          const Divider(height: 20),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => context.push('/order/${order.id}'),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(0, 36),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text('TRACK ORDER', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    for (final item in order.items) {
                      ref.read(cartProvider.notifier).addProduct(item.product);
                    }
                    context.push('/cart');
                  },
                  icon: const Icon(LucideIcons.rotateCcw, size: 14),
                  label: const Text('REORDER'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    minimumSize: const Size(0, 36),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
