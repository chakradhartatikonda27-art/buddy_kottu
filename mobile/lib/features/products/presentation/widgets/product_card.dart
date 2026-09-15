import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/models/product_model.dart';
import '../../../cart/presentation/cart_provider.dart';
import '../../../../core/constants/app_colors.dart';

class ProductCard extends ConsumerWidget {
  final ProductModel product;
  final VoidCallback? onTap;

  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartProvider);
    final cartItemIndex = cartState.items.indexWhere((i) => i.product.id == product.id);
    final quantity = cartItemIndex >= 0 ? cartState.items[cartItemIndex].quantity : 0;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.cardBorder, width: 1.5),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Hero Box
            Container(
              height: 80,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFF6F7F4),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: Center(
                child: Text(
                  _getProductEmoji(product.categoryId),
                  style: const TextStyle(fontSize: 28),
                ),
              ),
            ),

            // Product Info Container
            Padding(
              padding: const EdgeInsets.all(9),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (product.hasDiscount)
                    Container(
                      margin: const EdgeInsets.only(bottom: 2),
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.accent,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        '${product.discountPercentage.toInt()}% OFF',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 9.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  Text(
                    product.brand.toUpperCase(),
                    style: GoogleFonts.inter(
                      color: AppColors.muted,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 1),
                  Text(
                    product.name,
                    style: GoogleFonts.inter(
                      color: AppColors.text,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      height: 1.25,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text(
                        '₹${product.price.toStringAsFixed(0)}',
                        style: GoogleFonts.inter(
                          color: AppColors.text,
                          fontSize: 13.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      if (product.hasDiscount) ...[
                        const SizedBox(width: 5),
                        Text(
                          '₹${product.mrp.toStringAsFixed(0)}',
                          style: GoogleFonts.inter(
                            color: AppColors.muted,
                            fontSize: 10.5,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Add Button vs Stepper
                  if (quantity == 0)
                    OutlinedButton(
                      onPressed: () {
                        ref.read(cartProvider.notifier).addProduct(product);
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.green,
                        side: const BorderSide(color: AppColors.green, width: 1.5),
                        minimumSize: const Size(double.infinity, 32),
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text(
                        '+ Add',
                        style: GoogleFonts.inter(fontSize: 11.5, fontWeight: FontWeight.w700),
                      ),
                    )
                  else
                    Container(
                      height: 32,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: AppColors.greenDark,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              ref.read(cartProvider.notifier).updateQuantity(product.id, quantity - 1);
                            },
                            child: const Text('−', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                          ),
                          Text(
                            '$quantity',
                            style: GoogleFonts.inter(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700),
                          ),
                          GestureDetector(
                            onTap: () {
                              ref.read(cartProvider.notifier).updateQuantity(product.id, quantity + 1);
                            },
                            child: const Text('+', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getProductEmoji(String categoryId) {
    switch (categoryId) {
      case 'c1': return '🍜';
      case 'c3': return '🥤';
      case 'c5': return '🍟';
      case 'c6': return '🍫';
      case 'c7': return '🍪';
      case 'c11': return '🧼';
      default: return '📦';
    }
  }
}
