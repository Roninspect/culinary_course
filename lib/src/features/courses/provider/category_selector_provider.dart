// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categorySelectorNotifierProvider =
    StateNotifierProvider.family<CategorySelectorNotifier, String, String>(
        (ref, initialString) {
  return CategorySelectorNotifier(initialString);
});

class CategorySelectorNotifier extends StateNotifier<String> {
  String? initialString;
  CategorySelectorNotifier(initialString) : super(initialString!);

  void selectCategory(String category) {
    state = category;
  }
}
