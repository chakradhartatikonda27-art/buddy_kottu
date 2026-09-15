import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../cart_provider.dart';
import '../../../../core/constants/app_colors.dart';

class PersistentCartBar extends ConsumerWidget {
  const PersistentCartBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartProvider);

    if (cartState.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: SafeArea(
        child: Material(
          elevation: 8,
          borderRadius: BorderRadius.circular(14),
          color: AppColors.greenDark,
          child: InkWell(
            onTap: () => context.push('/cart'),
            borderRadius: BorderRadius.circular(14),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
              height: 52,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Cart · ${cartState.totalItemCount} item${cartState.totalItemCount > 1 ? 's' : ''}',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    '₹${cartState.grandTotal.toStringAsFixed(0)} →',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
