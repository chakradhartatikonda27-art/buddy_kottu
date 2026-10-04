import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';

class CategoryItem {
  final String id;
  final String title;
  final String imageUrl;

  const CategoryItem(this.id, this.title, this.imageUrl);
}

final List<CategoryItem> categoriesList = [
  const CategoryItem(
    'c1',
    'Hostel Essentials',
    'https://images.unsplash.com/photo-1544816155-12df9643f363?w=500&q=80',
  ),
  const CategoryItem(
    'c2',
    'Hospital Essentials',
    'https://images.unsplash.com/photo-1603398938378-e54eab446dde?w=500&q=80',
  ),
  const CategoryItem(
    'c3',
    'Cool Drinks & Water',
    'https://images.unsplash.com/photo-1622483767028-3f66f32aef97?w=500&q=80',
  ),
  const CategoryItem(
    'c4',
    'Ice Creams',
    'https://images.unsplash.com/photo-1570197788417-0e82375c9371?w=500&q=80',
  ),
  const CategoryItem(
    'c5',
    'Chips & Snacks',
    'https://images.unsplash.com/photo-1566478989037-eec170784d0b?w=500&q=80',
  ),
  const CategoryItem(
    'c6',
    'Chocolates & Candies',
    'https://images.unsplash.com/photo-1549007994-cb92caebd54b?w=500&q=80',
  ),
  const CategoryItem(
    'c7',
    'Biscuits & Bakery',
    'https://images.unsplash.com/photo-1558961363-fa8fdf82db35?w=500&q=80',
  ),
  const CategoryItem(
    'c8',
    'Instant Food',
    'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?w=500&q=80',
  ),
  const CategoryItem(
    'c9',
    'Dairy Eggs & Breakfast',
    'https://images.unsplash.com/photo-1528750997573-59b89d66f4f7?w=500&q=80',
  ),
  const CategoryItem(
    'c10',
    'Grocery Essentials',
    'https://images.unsplash.com/photo-1542838132-92c53300491e?w=500&q=80',
  ),
  const CategoryItem(
    'c11',
    'Personal Care',
    'https://images.unsplash.com/photo-1556228720-195a672e8a03?w=500&q=80',
  ),
  const CategoryItem(
    'c12',
    'Baby Care',
    'https://images.unsplash.com/photo-1515488042361-ee00e0ddd4e4?w=500&q=80',
  ),
  const CategoryItem(
    'c13',
    'Home Cleaning',
    'https://images.unsplash.com/photo-1583947215259-38e31be8751f?w=500&q=80',
  ),
  const CategoryItem(
    'c14',
    'Stationery',
    'https://images.unsplash.com/photo-1585336261026-875a60a1c96b?w=500&q=80',
  ),
  const CategoryItem(
    'c15',
    'Kitchen & Plastic Items',
    'https://images.unsplash.com/photo-1610557892470-55d9e80c0bce?w=500&q=80',
  ),
  const CategoryItem(
    'c16',
    'Daily Needs',
    'https://images.unsplash.com/photo-1516594798947-e65505dbb29d?w=500&q=80',
  ),
  const CategoryItem(
    'c17',
    'Household Essentials',
    'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?w=500&q=80',
  ),
  const CategoryItem(
    'c18',
    'Seasonal Products',
    'https://images.unsplash.com/photo-1517420704952-d9f39e95b43e?w=500&q=80',
  ),
  const CategoryItem(
    'c19',
    'Offers & Discounts',
    'https://images.unsplash.com/photo-1513151233558-d860c5398176?w=500&q=80',
  ),
  const CategoryItem(
    'c20',
    'New Arrivals',
    'https://images.unsplash.com/photo-1513885535751-8b9238bd345a?w=500&q=80',
  ),
];

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  String selectedCategoryId = 'c5'; // Chips & Snacks highlighted by default like design

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'All Categories',
              style: GoogleFonts.sora(
                color: const Color(0xFF0F172A),
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              'Find what you need fast',
              style: GoogleFonts.inter(
                color: const Color(0xFF64748B),
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.search, color: Color(0xFF0F172A)),
            onPressed: () => context.go('/search'),
          ),
        ],
      ),
      body: SafeArea(
        child: GridView.builder(
          padding: const EdgeInsets.all(12),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.78,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: categoriesList.length,
          itemBuilder: (context, index) {
            final cat = categoriesList[index];
            final isSelected = cat.id == selectedCategoryId;

            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedCategoryId = cat.id;
                });
                context.go('/search?q=${Uri.encodeComponent(cat.title)}');
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected ? const Color(0xFFFF5722) : const Color(0xFFE2E8F0),
                    width: isSelected ? 2.0 : 1.0,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Top Photography Image
                      Expanded(
                        child: Image.network(
                          cat.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            color: const Color(0xFFFFEDD5),
                            child: const Center(
                              child: Icon(LucideIcons.shoppingBag, color: Color(0xFFFF5722)),
                            ),
                          ),
                        ),
                      ),
                      // Bottom Label Container
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                        color: Colors.white,
                        child: Text(
                          cat.title,
                          style: GoogleFonts.sora(
                            color: const Color(0xFF0F172A),
                            fontSize: 11.5,
                            fontWeight: FontWeight.w700,
                            height: 1.2,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
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
