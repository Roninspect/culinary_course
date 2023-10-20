import 'package:culinary_course/src/features/search/provider/selected_category_provider.dart';
import 'package:culinary_course/src/features/search/widgets/category_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilterPage extends ConsumerWidget {
  const FilterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Filter"),
        actions: [
          TextButton(
              onPressed: () {
                ref.invalidate(selectedCategoryProvider);
              },
              child: const Text(
                "Reset all",
                style: TextStyle(fontSize: 16, color: Colors.red),
              ))
        ],
      ),
      body: const Column(
        children: [
          SizedBox(height: 20),
          CategoryDropDown(),
        ],
      ),
    );
  }
}
