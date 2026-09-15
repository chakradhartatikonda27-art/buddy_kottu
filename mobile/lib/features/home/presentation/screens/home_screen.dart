import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../products/data/mock_products.dart';
import '../../../products/presentation/widgets/product_card.dart';
import '../../../packs/presentation/packs_provider.dart';
import '../../../packs/presentation/widgets/pack_card.dart';
import '../../../../core/constants/app_colors.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final packs = ref.watch(packsProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top Header Location Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              color: AppColors.white,
              child: Row(
                children: [
                  const Text('📍', style: TextStyle(fontSize: 15)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Deliver to · Hostel Block B',
                          style: GoogleFonts.inter(
                            fontSize: 10.5,
                            color: AppColors.muted,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'GSL Hospital Road',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: AppColors.text,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              '● Open · closes 10 PM',
                              style: GoogleFonts.inter(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: AppColors.green,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Search Bar
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                      child: InkWell(
                        onTap: () => context.go('/search'),
                        borderRadius: BorderRadius.circular(14),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: AppColors.cardBorder, width: 1.5),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.search, size: 16, color: AppColors.muted),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Search products, brands, snacks, drinks...',
                                  style: GoogleFonts.inter(
                                    fontSize: 13.5,
                                    color: AppColors.muted,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Banner Carousel
                    SizedBox(
                      height: 122,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
                        children: [
                          _buildBannerSlide(
                            eyebrow: 'Limited time',
                            title: 'Flat ₹50 off',
                            sub: 'On orders above ₹299',
                            emoji: '🏷️',
                            gradient: const LinearGradient(colors: [Color(0xFF16A34A), Color(0xFF0B3D24)]),
                          ),
                          _buildBannerSlide(
                            eyebrow: 'This week only',
                            title: 'Free delivery',
                            sub: 'On every order above ₹199',
                            emoji: '🛵',
                            gradient: const LinearGradient(colors: [Color(0xFFF97316), Color(0xFFC2410C)]),
                          ),
                          _buildBannerSlide(
                            eyebrow: 'Just landed',
                            title: 'New arrivals',
                            sub: 'Fresh snacks & drinks in stock',
                            emoji: '✨',
                            gradient: const LinearGradient(colors: [Color(0xFF0F766E), Color(0xFF0B3D24)]),
                          ),
                        ],
                      ),
                    ),

                    // Chip Row Category Options
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.fromLTRB(16, 14, 16, 4),
                      child: Row(
                        children: [
                          _buildChip('🏠', 'Hostel', () => context.go('/search?q=hostel')),
                          _buildChip('🏥', 'Hospital', () => context.go('/search?q=hospital')),
                          _buildChip('🥤', 'Drinks', () => context.go('/search?q=cold drink')),
                          _buildChip('🍟', 'Snacks', () => context.go('/search?q=chips')),
                          _buildChip('🗂️', 'All', () => context.go('/categories')),
                          _buildChip('🏷️', 'Offers', () => context.go('/offers')),
                        ],
                      ),
                    ),

                    // Section Head: Smart Packs
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Smart packs',
                            style: GoogleFonts.sora(fontSize: 14.5, fontWeight: FontWeight.w700),
                          ),
                          Text(
                            'See all',
                            style: GoogleFonts.inter(fontSize: 11.5, color: AppColors.green, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),

                    // Pack Row
                    SizedBox(
                      height: 120,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: packs.length,
                        itemBuilder: (context, index) {
                          return PackCard(pack: packs[index]);
                        },
                      ),
                    ),

                    // Section Head: Popular Near You
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Popular near you',
                            style: GoogleFonts.sora(fontSize: 14.5, fontWeight: FontWeight.w700),
                          ),
                          Text(
                            'See all',
                            style: GoogleFonts.inter(fontSize: 11.5, color: AppColors.green, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),

                    // Product Grid
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(16, 6, 16, 90),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.72,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: mockProductsList.length,
                      itemBuilder: (context, index) {
                        return ProductCard(product: mockProductsList[index]);
                      },
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

  Widget _buildBannerSlide({
    required String eyebrow,
    required String title,
    required String sub,
    required String emoji,
    required LinearGradient gradient,
  }) {
    return Container(
      width: 284,
      height: 108,
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(eyebrow, style: GoogleFonts.inter(color: Colors.white70, fontSize: 10.5, fontWeight: FontWeight.w600)),
              const SizedBox(height: 2),
              Text(title, style: GoogleFonts.sora(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w800)),
              Text(sub, style: GoogleFonts.inter(color: Colors.white90, fontSize: 10.5, fontWeight: FontWeight.w500)),
            ],
          ),
          Positioned(
            right: -6,
            bottom: -10,
            child: Text(emoji, style: const TextStyle(fontSize: 54)),
          ),
        ],
      ),
    );
  }

  Widget _buildChip(String emoji, String label, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 9),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.cardBorder, width: 1.5),
          ),
          child: Column(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 4),
              Text(label, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.text)),
            ],
          ),
        ),
      ),
    );
  }
}
