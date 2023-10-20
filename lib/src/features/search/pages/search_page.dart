import 'package:culinary_course/src/core/constants/colors.dart';
import 'package:culinary_course/src/features/courses/controllers/course_controller.dart';
import 'package:culinary_course/src/features/search/controller/search_controller.dart';
import 'package:culinary_course/src/features/search/provider/search_result_provider.dart';
import 'package:culinary_course/src/features/search/provider/selected_category_provider.dart';
import 'package:culinary_course/src/models/category.dart';
import 'package:culinary_course/src/models/course.dart';
import 'package:culinary_course/src/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  TextEditingController queryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final searches = ref.watch(searchResultProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final length = searches.value!.length;

    void shouldSearchAgain(String? value) {
      if (value!.isNotEmpty) {
        if (selectedCategory != null) {
          ref
              .watch(searchResultProvider.notifier)
              .searchCourseByTitle(query: value, selectedCategory);
        } else {
          ref
              .watch(searchResultProvider.notifier)
              .searchCourseByTitle(query: value, null);
        }
      } else {
        null;
      }
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: queryController,
                onChanged: (value) => value.isNotEmpty
                    ? selectedCategory != null
                        ? ref
                            .watch(searchResultProvider.notifier)
                            .searchCourseByTitle(query: value, selectedCategory)
                        : ref
                            .watch(searchResultProvider.notifier)
                            .searchCourseByTitle(query: value, null)
                    : null,
                onSubmitted: (value) =>
                    searches.value!.isEmpty ? shouldSearchAgain(value) : null,
                decoration: InputDecoration(
                  hintText: "Search",
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                      onPressed: () {
                        shouldSearchAgain(queryController.text);
                      },
                      icon: const Icon(Icons.search)),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: primaryColor),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Spacer(),
                const Text("Filter",
                    style: TextStyle(
                      fontSize: 20,
                    )),
                IconButton(
                    onPressed: () {
                      context.pushNamed(AppRoutes.filter.name);
                    },
                    icon: const Icon(Icons.filter_list_sharp)),
              ],
            ),
            Text(
              "Total Courses Found ($length)",
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),
            queryController.text.isNotEmpty
                ? Expanded(
                    child: searches.when(
                      data: (data) {
                        return data.isEmpty
                            ? const Center(
                                child: Text("No Result"),
                              )
                            : ListView.builder(
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  final singleResult = data[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: ListTile(
                                      onTap: () => context.pushNamed(
                                          AppRoutes.course.name,
                                          pathParameters: {
                                            "id": singleResult.id
                                          },
                                          extra: singleResult),
                                      contentPadding: EdgeInsets.zero,
                                      leading: SizedBox(
                                        width: 100,
                                        child: Image.network(
                                          singleResult.thumbnail,
                                          fit: BoxFit.fitWidth,
                                        ),
                                      ),
                                      title: Text(singleResult.title,
                                          style: const TextStyle(
                                            fontSize: 20,
                                          )),
                                    ),
                                  );
                                },
                              );
                      },
                      error: (error, stackTrace) {
                        return Text(error.toString());
                      },
                      loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  )
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
