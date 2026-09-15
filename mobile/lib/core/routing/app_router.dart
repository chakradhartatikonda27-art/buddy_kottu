import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/categories/presentation/screens/categories_screen.dart';
import '../../features/search/presentation/screens/search_screen.dart';
import '../../features/orders/presentation/screens/orders_screen.dart';
import '../../features/orders/presentation/screens/order_detail_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/cart/presentation/screens/cart_screen.dart';
import '../../features/checkout/presentation/screens/checkout_screen.dart';
import '../../features/cart/presentation/widgets/persistent_cart_bar.dart';
import '../constants/app_colors.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return ScaffoldWithBottomNavBar(child: child);
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/categories',
          builder: (context, state) => const CategoriesScreen(),
        ),
        GoRoute(
          path: '/search',
          builder: (context, state) {
            final q = state.uri.queryParameters['q'];
            return SearchScreen(initialQuery: q);
          },
        ),
        GoRoute(
          path: '/orders',
          builder: (context, state) => const OrdersScreen(),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfileScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/cart',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const CartScreen(),
    ),
    GoRoute(
      path: '/checkout',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const CheckoutScreen(),
    ),
    GoRoute(
      path: '/order/:id',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        final id = state.pathParameters['id'] ?? '';
        return OrderDetailScreen(orderId: id);
      },
    ),
  ],
);

class ScaffoldWithBottomNavBar extends StatelessWidget {
  final Widget child;

  const ScaffoldWithBottomNavBar({
    super.key,
    required this.child,
  });

  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.pathname;
    if (location == '/') return 0;
    if (location.startsWith('/categories')) return 1;
    if (location.startsWith('/search')) return 2;
    if (location.startsWith('/orders')) return 3;
    if (location.startsWith('/profile')) return 4;
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/categories');
        break;
      case 2:
        context.go('/search');
        break;
      case 3:
        context.go('/orders');
        break;
      case 4:
        context.go('/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = _calculateSelectedIndex(context);

    return Scaffold(
      body: Stack(
        children: [
          child,
          const Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: PersistentCartBar(),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (int idx) => _onItemTapped(idx, context),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textMuted,
        selectedFontSize: 11,
        unselectedFontSize: 11,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(LucideIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(LucideIcons.grid),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(LucideIcons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(LucideIcons.package),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(LucideIcons.user),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
