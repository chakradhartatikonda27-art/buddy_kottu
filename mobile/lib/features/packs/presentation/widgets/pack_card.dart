import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/models/pack_model.dart';
import '../../../cart/presentation/cart_provider.dart';
import '../../../../core/constants/app_colors.dart';

class PackCard extends ConsumerWidget {
  final PackModel pack;

  const PackCard({
    super.key,
    required this.pack,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 158,
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.cardBorder, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                pack.title,
                style: GoogleFonts.sora(
                  color: AppColors.text,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 3),
              Text(
                pack.subtitle,
                style: GoogleFonts.inter(
                  color: AppColors.muted,
                  fontSize: 10.5,
                  height: 1.4,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              ref.read(cartProvider.notifier).addPack(pack);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${pack.title} added!'),
                  backgroundColor: AppColors.greenDark,
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.greenDark,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 32),
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
              elevation: 0,
            ),
            child: Text(
              'Add pack · ₹${pack.price.toStringAsFixed(0)}',
              style: GoogleFonts.inter(
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
