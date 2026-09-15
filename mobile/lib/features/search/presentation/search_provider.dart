import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../products/domain/models/product_model.dart';
import '../../products/data/mock_products.dart';

class SearchState {
  final String query;
  final List<ProductModel> results;
  final bool isLoading;
  final List<String> recentSearches;
  final List<String> popularSearches;

  const SearchState({
    this.query = '',
    this.results = const [],
    this.isLoading = false,
    this.recentSearches = const ['Maggi', 'Coke', 'Hostel soap', 'Kinley Water'],
    this.popularSearches = const [
      'cold drink',
      'hostel',
      'hospital',
      'night study',
      'biscuits',
      'milk',
      'chips',
    ],
  });

  SearchState copyWith({
    String? query,
    List<ProductModel>? results,
    bool? isLoading,
    List<String>? recentSearches,
    List<String>? popularSearches,
  }) {
    return SearchState(
      query: query ?? this.query,
      results: results ?? this.results,
      isLoading: isLoading ?? this.isLoading,
      recentSearches: recentSearches ?? this.recentSearches,
      popularSearches: popularSearches ?? this.popularSearches,
    );
  }
}

class SearchNotifier extends StateNotifier<SearchState> {
  SearchNotifier() : super(const SearchState());

  void search(String rawQuery) {
    final query = rawQuery.trim().toLowerCase();
    if (query.isEmpty) {
      state = state.copyWith(query: '', results: [], isLoading: false);
      return;
    }

    state = state.copyWith(query: rawQuery, isLoading: true);

    // Intent engine mapping
    final List<ProductModel> matchedProducts;

    if (query.contains('cold drink') || query.contains('drink') || query.contains('soft drink')) {
      matchedProducts = mockProductsList
          .where((p) => p.categoryId == 'c3' || p.keywords.contains('drink'))
          .toList();
    } else if (query.contains('hostel') || query.contains('night study') || query.contains('study')) {
      matchedProducts = mockProductsList
          .where((p) => p.keywords.contains('hostel') || p.keywords.contains('noodles') || p.keywords.contains('snack'))
          .toList();
    } else if (query.contains('hospital')) {
      matchedProducts = mockProductsList
          .where((p) => p.keywords.contains('hospital') || p.keywords.contains('water') || p.keywords.contains('juice'))
          .toList();
    } else {
      // General name, brand, keyword match
      matchedProducts = mockProductsList.where((p) {
        return p.nameNormalized.contains(query) ||
            p.brandNormalized.contains(query) ||
            p.keywords.any((k) => k.contains(query)) ||
            p.searchTokens.any((t) => t.contains(query));
      }).toList();
    }

    // Save search to recents if not already there
    final updatedRecents = List<String>.from(state.recentSearches);
    if (!updatedRecents.contains(rawQuery) && rawQuery.length > 2) {
      updatedRecents.insert(0, rawQuery);
      if (updatedRecents.length > 5) updatedRecents.removeLast();
    }

    state = state.copyWith(
      results: matchedProducts,
      isLoading: false,
      recentSearches: updatedRecents,
    );
  }

  void clearSearch() {
    state = state.copyWith(query: '', results: [], isLoading: false);
  }
}

final searchProvider = StateNotifierProvider<SearchNotifier, SearchState>((ref) {
  return SearchNotifier();
});
