import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

class CategoryItem {
  final String id;
  final String title;
  final IconData icon;
  final Color color;

  const CategoryItem(this.id, this.title, this.icon, this.color);
}

final List<CategoryItem> categoriesList = [
  const CategoryItem('c1', 'Hostel Essentials', LucideIcons.home, Color(0xFFEF4444)),
  const CategoryItem('c2', 'Hospital Essentials', LucideIcons.heartHandshake, Color(0xFF3B82F6)),
  const CategoryItem('c3', 'Cool Drinks & Water', LucideIcons.cupSoda, Color(0xFF10B981)),
  const CategoryItem('c4', 'Ice Creams', LucideIcons.iceCream, Color(0xFFEC4899)),
  const CategoryItem('c5', 'Chips & Snacks', LucideIcons.cookie, Color(0xFFF59E0B)),
  const CategoryItem('c6', 'Chocolates & Candies', LucideIcons.candy, Color(0xFF8B5CF6)),
  const CategoryItem('c7', 'Biscuits & Bakery', LucideIcons.sandwich, Color(0xFFD97706)),
  const CategoryItem('c8', 'Instant Food', LucideIcons.soup, Color(0xFFDC2626)),
  const CategoryItem('c9', 'Dairy, Eggs & Breakfast', LucideIcons.egg, Color(0xFF059669)),
  const CategoryItem('c10', 'Grocery Essentials', LucideIcons.shoppingBag, Color(0xFF4F46E5)),
  const CategoryItem('c11', 'Personal Care', LucideIcons.sparkles, Color(0xFF2563EB)),
  const CategoryItem('c12', 'Baby Care', LucideIcons.baby, Color(0xFFF43F5E)),
  const CategoryItem('c13', 'Home Cleaning', LucideIcons.sprayCan, Color(0xFF0284C7)),
  const CategoryItem('c14', 'Stationery', LucideIcons.penTool, Color(0xFF7C3AED)),
  const CategoryItem('c15', 'Kitchen & Plastic Items', LucideIcons.utensils, Color(0xFFEA580C)),
  const CategoryItem('c16', 'Daily Needs', LucideIcons.clock, Color(0xFF16A34A)),
  const CategoryItem('c17', 'Household Essentials', LucideIcons.lamp, Color(0xFF65A30D)),
  const CategoryItem('c18', 'Seasonal Products', LucideIcons.sun, Color(0xFFCA8A04)),
  const CategoryItem('c19', 'Offers & Discounts', LucideIcons.badgePercent, Color(0xFFE11D48)),
  const CategoryItem('c20', 'New Arrivals', LucideIcons.sparkle, Color(0xFF0D9488)),
];

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Categories'),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.search),
            onPressed: () => context.go('/search'),
          ),
        ],
      ),
      body: SafeArea(
        child: GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: categoriesList.length,
          itemBuilder: (context, index) {
            final cat = categoriesList[index];
            return Container(
              decoration: BoxDecoration(
                color: cat.color.withOpacity(0.08),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: cat.color.withOpacity(0.3),
                  width: 1.2,
                ),
              ),
              child: InkWell(
                onTap: () => context.go('/search?q=${Uri.encodeComponent(cat.title)}'),
                borderRadius: BorderRadius.circular(14),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: cat.color.withOpacity(0.18),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          cat.icon,
                          color: cat.color,
                          size: 22,
                        ),
                      ),
                      Text(
                        cat.title,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          height: 1.2,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
