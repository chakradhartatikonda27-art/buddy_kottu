import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../auth/presentation/auth_provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Details Card
              Container(
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
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: AppColors.primaryLight,
                      child: Text(
                        user.name.substring(0, 1),
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.name,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            user.phone,
                            style: const TextStyle(color: AppColors.textMuted, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Buddy Points Loyalty Banner
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF16A34A), Color(0xFF15803D)],
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(LucideIcons.coins, color: Colors.white, size: 24),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'BUDDY POINTS',
                            style: TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.w800),
                          ),
                          Text(
                            '240 Points Available',
                            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppColors.primary,
                        minimumSize: const Size(70, 32),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                      ),
                      child: const Text('REDEEM', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Options List
              Text(
                'ACCOUNT & PREFERENCES',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 10),
              _profileTile(context, icon: LucideIcons.mapPin, title: 'Saved Addresses', subtitle: 'Hostel Block B, GSL OPD'),
              _profileTile(context, icon: LucideIcons.heart, title: 'Favorites & Wishlist', subtitle: 'Quick access items'),
              _profileTile(context, icon: LucideIcons.store, title: 'Store Info & Hours', subtitle: 'Sri Siva General Stores (6 AM - 10 PM)'),
              _profileTile(context, icon: LucideIcons.phone, title: 'Help & Support', subtitle: 'WhatsApp store assistant'),
              const SizedBox(height: 24),

              // Logout Button
              OutlinedButton.icon(
                onPressed: () {
                  ref.read(authProvider.notifier).logout();
                },
                icon: const Icon(LucideIcons.logOut, color: AppColors.error),
                label: const Text('LOG OUT', style: TextStyle(color: AppColors.error, fontWeight: FontWeight.bold)),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                  side: const BorderSide(color: AppColors.error),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _profileTile(BuildContext context, {required IconData icon, required String title, required String subtitle}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).brightness == Brightness.dark
              ? AppColors.darkCardBorder
              : AppColors.cardBorder,
        ),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary, size: 20),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        subtitle: Text(subtitle, style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
        trailing: const Icon(LucideIcons.chevronRight, size: 18, color: AppColors.textMuted),
        onTap: () {},
      ),
    );
  }
}
