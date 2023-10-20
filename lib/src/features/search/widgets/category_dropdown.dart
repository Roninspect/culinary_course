import 'package:culinary_course/src/features/courses/controllers/course_controller.dart';
import 'package:culinary_course/src/features/search/provider/selected_category_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryDropDown extends ConsumerWidget {
  const CategoryDropDown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(selectedCategoryProvider);
    return ref.watch(getAllCategoriesProvider).when(
          data: (data) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ButtonTheme(
                alignedDropdown: true,
                minWidth: 200,
                child: DropdownButtonFormField<String>(
                  alignment: Alignment.topCenter,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      //<-- SEE HERE
                      borderSide:
                          const BorderSide(color: Colors.black, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      //<-- SEE HERE
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          const BorderSide(color: Colors.black, width: 1),
                    ),
                    filled: true,
                  ),
                  hint: const Text(
                    "Select Category",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  isDense: true,
                  value: selectedCategory,
                  items: data
                      .map((e) => DropdownMenuItem<String>(
                          value: e.name,
                          child: SizedBox(width: 200, child: Text(e.name))))
                      .toList(),
                  onChanged: (value) {
                    ref
                        .read(selectedCategoryProvider.notifier)
                        .selectCategory(selectedCategory: value!);
                  },
                ),
              ),
            );
          },
          error: (error, stackTrace) => Text(error.toString()),
          loading: () => const CircularProgressIndicator(),
        );
  }
}
