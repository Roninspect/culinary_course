import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_category_provider.g.dart';

@Riverpod(keepAlive: true)
class SelectedCategory extends _$SelectedCategory {
  @override
  String? build() {
    return null;
  }

  void selectCategory({required String selectedCategory}) {
    state = selectedCategory;
  }
}
