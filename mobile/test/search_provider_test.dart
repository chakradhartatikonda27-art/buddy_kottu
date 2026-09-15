import 'package:flutter_test/flutter_test.dart';
import 'package:buddy_kottu/features/search/presentation/search_provider.dart';

void main() {
  group('SearchNotifier Intent Engine Tests', () {
    late SearchNotifier searchNotifier;

    setUp(() {
      searchNotifier = SearchNotifier();
    });

    test('Searching "cold drink" returns drink products', () {
      searchNotifier.search('cold drink');

      expect(searchNotifier.state.results.isNotEmpty, isTrue);
      expect(
        searchNotifier.state.results.any((p) => p.name.contains('Coke') || p.name.contains('Thums Up')),
        isTrue,
      );
    });

    test('Searching "hostel" returns hostel essentials', () {
      searchNotifier.search('hostel');

      expect(searchNotifier.state.results.isNotEmpty, isTrue);
      expect(
        searchNotifier.state.results.any((p) => p.name.contains('Maggi') || p.name.contains('Lays')),
        isTrue,
      );
    });

    test('Searching empty string clears results', () {
      searchNotifier.search('maggi');
      searchNotifier.clearSearch();

      expect(searchNotifier.state.results.isEmpty, isTrue);
      expect(searchNotifier.state.query.isEmpty, isTrue);
    });
  });
}
