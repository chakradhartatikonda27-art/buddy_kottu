import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../search_provider.dart';
import '../../../products/presentation/widgets/product_card.dart';
import '../../../../core/constants/app_colors.dart';

class SearchScreen extends ConsumerStatefulWidget {
  final String? initialQuery;

  const SearchScreen({
    super.key,
    this.initialQuery,
  });

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.initialQuery != null && widget.initialQuery!.isNotEmpty) {
      _controller.text = widget.initialQuery!;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(searchProvider.notifier).search(widget.initialQuery!);
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(searchProvider);

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.only(right: 16),
          child: TextField(
            controller: _controller,
            autofocus: widget.initialQuery == null || widget.initialQuery!.isEmpty,
            onChanged: (text) {
              ref.read(searchProvider.notifier).search(text);
            },
            decoration: InputDecoration(
              hintText: 'Search products, brands, snacks, drinks...',
              hintStyle: const TextStyle(fontSize: 13, color: AppColors.textMuted),
              border: InputBorder.none,
              suffixIcon: _controller.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(LucideIcons.x, size: 18),
                      onPressed: () {
                        _controller.clear();
                        ref.read(searchProvider.notifier).clearSearch();
                      },
                    )
                  : null,
            ),
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ),
      body: SafeArea(
        child: searchState.query.isEmpty
            ? _buildSearchSuggestions(context, ref, searchState)
            : searchState.results.isEmpty
                ? _buildEmptyResults(context)
                : _buildSearchResults(context, searchState),
      ),
    );
  }

  Widget _buildSearchSuggestions(BuildContext context, WidgetRef ref, SearchState searchState) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Popular Intents (Blinkit/Zepto-style fast discovery)
          Text(
            'QUICK INTENT SEARCH',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 12,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: searchState.popularSearches.map((term) {
              return ActionChip(
                avatar: const Icon(LucideIcons.sparkles, size: 14, color: AppColors.primary),
                label: Text(
                  term,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                backgroundColor: AppColors.primaryLight,
                onPressed: () {
                  _controller.text = term;
                  ref.read(searchProvider.notifier).search(term);
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 24),

          // Recent Searches
          if (searchState.recentSearches.isNotEmpty) ...[
            Text(
              'RECENT SEARCHES',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 12,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 10),
            Column(
              children: searchState.recentSearches.map((query) {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(LucideIcons.history, size: 18, color: AppColors.textMuted),
                  title: Text(query, style: const TextStyle(fontSize: 14)),
                  trailing: const Icon(LucideIcons.arrowUpLeft, size: 16, color: AppColors.textMuted),
                  onTap: () {
                    _controller.text = query;
                    ref.read(searchProvider.notifier).search(query);
                  },
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildEmptyResults(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: AppColors.accentLight,
                shape: BoxShape.circle,
              ),
              child: const Icon(LucideIcons.searchX, color: AppColors.accent, size: 40),
            ),
            const SizedBox(height: 16),
            Text(
              'No products found',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Try searching for "cold drink", "hostel", "maggi", or "water"',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.textMuted, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults(BuildContext context, SearchState searchState) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.66,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: searchState.results.length,
      itemBuilder: (context, index) {
        final product = searchState.results[index];
        return ProductCard(
          product: product,
          onTap: () => context.push('/product/${product.id}'),
        );
      },
    );
  }
}
