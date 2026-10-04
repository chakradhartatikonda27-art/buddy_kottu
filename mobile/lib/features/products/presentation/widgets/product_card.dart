import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../domain/models/product_model.dart';
import '../../../cart/presentation/cart_provider.dart';
import '../../../../core/constants/app_colors.dart';

class ProductCard extends ConsumerStatefulWidget {
  final ProductModel product;
  final VoidCallback? onTap;

  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
  });

  @override
  ConsumerState<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends ConsumerState<ProductCard> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final cartState = ref.watch(cartProvider);
    final cartItemIndex = cartState.items.indexWhere((i) => i.product.id == widget.product.id);
    final quantity = cartItemIndex >= 0 ? cartState.items[cartItemIndex].quantity : 0;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFF1F5F9), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Box & Badges Container
            Container(
              height: 125,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFFFF7ED).withOpacity(0.6),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
              ),
              child: Stack(
                children: [
                  // Product Emoji / Graphic Center
                  Center(
                    child: Text(
                      _getProductEmoji(widget.product.categoryId, widget.product.name),
                      style: const TextStyle(fontSize: 44),
                    ),
                  ),

                  // Discount Badge (Top-Left)
                  if (widget.product.hasDiscount)
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF5722),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${widget.product.discountPercentage.toInt()}% OFF',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),

                  // Favorite Heart Icon Button (Top-Right)
                  Positioned(
                    top: 10,
                    right: 10,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          isFavorite = !isFavorite;
                        });
                      },
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        child: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          size: 16,
                          color: isFavorite ? const Color(0xFFFF5722) : const Color(0xFF94A3B8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Product Details Area
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.product.name,
                          style: GoogleFonts.inter(
                            color: const Color(0xFF0F172A),
                            fontSize: 13.5,
                            fontWeight: FontWeight.w700,
                            height: 1.25,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          widget.product.brand,
                          style: GoogleFonts.inter(
                            color: const Color(0xFF94A3B8),
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Price Line
                        Row(
                          children: [
                            Text(
                              '₹${widget.product.price.toStringAsFixed(0)}',
                              style: GoogleFonts.inter(
                                color: const Color(0xFF0F172A),
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            if (widget.product.hasDiscount) ...[
                              const SizedBox(width: 6),
                              Text(
                                '₹${widget.product.mrp.toStringAsFixed(0)}',
                                style: GoogleFonts.inter(
                                  color: const Color(0xFF94A3B8),
                                  fontSize: 11.5,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 10),

                        // Add Button vs Stepper
                        if (quantity == 0)
                          OutlinedButton(
                            onPressed: () {
                              ref.read(cartProvider.notifier).addProduct(widget.product);
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xFFFF5722),
                              side: const BorderSide(color: Color(0xFFFF5722), width: 1.8),
                              minimumSize: const Size(double.infinity, 36),
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.add, size: 16),
                                const SizedBox(width: 4),
                                Text(
                                  'ADD',
                                  style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w800, letterSpacing: 0.5),
                                ),
                              ],
                            ),
                          )
                        else
                          Container(
                            height: 36,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFF5722),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    ref.read(cartProvider.notifier).updateQuantity(widget.product.id, quantity - 1);
                                  },
                                  child: const Icon(Icons.remove, color: Colors.white, size: 18),
                                ),
                                Text(
                                  '$quantity',
                                  style: GoogleFonts.inter(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w800),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    ref.read(cartProvider.notifier).updateQuantity(widget.product.id, quantity + 1);
                                  },
                                  child: const Icon(Icons.add, color: Colors.white, size: 18),
                                ),
                              ],
                            ),
                          ),
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

  String _getProductEmoji(String categoryId, String name) {
    final lower = name.toLowerCase();
    if (lower.contains('paper boat') || lower.contains('juice')) return '🧃';
    if (lower.contains('santoor') || lower.contains('soap')) return '🧼';
    if (lower.contains('parle-g') || lower.contains('biscuit')) return '🍪';
    if (lower.contains('hide & seek') || lower.contains('bourbon')) return '🍫';
    if (lower.contains('maggi') || lower.contains('noodle')) return '🍜';
    if (lower.contains('coca-cola') || lower.contains('coke')) return '🥤';
    return '📦';
  }
}
