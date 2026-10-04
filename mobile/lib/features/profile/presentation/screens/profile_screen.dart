import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../auth/presentation/auth_provider.dart';
import '../../../../core/constants/app_colors.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  Future<void> _launchAdminUrl() async {
    final Uri url = Uri.parse('https://buddy-kottu.vercel.app');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Header Bar with solid orange background & profile info
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 48, 20, 40),
              decoration: const BoxDecoration(
                color: Color(0xFFFF5722),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.white.withOpacity(0.3),
                    child: const Icon(LucideIcons.user, color: Colors.white, size: 28),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.name.isNotEmpty ? user.name : 'chakradhar tatikonda',
                          style: GoogleFonts.sora(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          user.email.isNotEmpty ? user.email : 'chakradhartatikonda27@gmail.com',
                          style: GoogleFonts.inter(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 12.5,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Content Stack (Buddy Points card overlapping the top orange header)
            Transform.translate(
              offset: const Offset(0, -20),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    // Buddy Points Loyalty Banner (Matching Image 1)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFF97316), Color(0xFFEA580C)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFFF5722).withOpacity(0.3),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text('🎁', style: TextStyle(fontSize: 14)),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Buddy Points',
                                    style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(
                                '0',
                                style: GoogleFonts.sora(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Earn 10 pts per ₹1 · Redeem for discounts',
                                style: GoogleFonts.inter(
                                  color: Colors.white.withOpacity(0.88),
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const Text('🎁', style: TextStyle(fontSize: 36)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    // 3 Stat Cards Row (Orders / Spent / Delivered)
                    Row(
                      children: [
                        _buildStatCard('0', 'Orders'),
                        const SizedBox(width: 10),
                        _buildStatCard('₹0', 'Spent'),
                        const SizedBox(width: 10),
                        _buildStatCard('0', 'Delivered'),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Options List Box
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFF1F5F9)),
                      ),
                      child: Column(
                        children: [
                          _menuOption(
                            icon: LucideIcons.mapPin,
                            title: 'Saved Addresses',
                            iconColor: const Color(0xFFFF5722),
                          ),
                          const Divider(height: 1, color: Color(0xFFF1F5F9)),
                          _menuOption(
                            icon: LucideIcons.star,
                            title: 'Favorites',
                            iconColor: const Color(0xFFFF5722),
                          ),
                          const Divider(height: 1, color: Color(0xFFF1F5F9)),
                          _menuOption(
                            icon: LucideIcons.gift,
                            title: 'Rewards & Referrals',
                            iconColor: const Color(0xFFFF5722),
                          ),
                          const Divider(height: 1, color: Color(0xFFF1F5F9)),
                          _menuOption(
                            icon: LucideIcons.headphones,
                            title: 'Help & Support',
                            iconColor: const Color(0xFF64748B),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Admin Dashboard Button (Matching Image 1)
                    InkWell(
                      onTap: _launchAdminUrl,
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF7ED),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFFFFEDD5), width: 1.2),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFE4E6).withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                LucideIcons.package,
                                color: Color(0xFFFF5722),
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Text(
                                'Admin Dashboard',
                                style: GoogleFonts.sora(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF0F172A),
                                ),
                              ),
                            ),
                            const Icon(
                              LucideIcons.chevronRight,
                              color: Color(0xFF94A3B8),
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Sign Out Button (Matching Image 1)
                    InkWell(
                      onTap: () {
                        ref.read(authProvider.notifier).logout();
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFFF1F5F9)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(LucideIcons.logOut, color: Color(0xFFFF5722), size: 18),
                            const SizedBox(width: 8),
                            Text(
                              'Sign out',
                              style: GoogleFonts.sora(
                                color: const Color(0xFFFF5722),
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String val, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFF1F5F9)),
        ),
        child: Column(
          children: [
            Text(
              val,
              style: GoogleFonts.sora(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF64748B),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuOption({
    required IconData icon,
    required String title,
    required Color iconColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 20),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 13.5,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0F172A),
              ),
            ),
          ),
          const Icon(
            LucideIcons.chevronRight,
            color: Color(0xFFCBD5E1),
            size: 18,
          ),
        ],
      ),
    );
  }
}
