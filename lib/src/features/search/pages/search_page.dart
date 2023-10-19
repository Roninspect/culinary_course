import 'package:culinary_course/src/core/constants/colors.dart';
import 'package:culinary_course/src/features/courses/controllers/course_controller.dart';
import 'package:culinary_course/src/features/search/controller/search_controller.dart';
import 'package:culinary_course/src/features/search/provider/search_result_provider.dart';
import 'package:culinary_course/src/models/category.dart';
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
    final length = searches.value!.length;
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
                    ? ref
                        .watch(searchResultProvider.notifier)
                        .searchCourseByTitle(query: value)
                    : null,
                decoration: const InputDecoration(
                  hintText: "Search",
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.search),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: primaryColor),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text("Filter",
                    style: TextStyle(
                      fontSize: 20,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.filter_list_sharp)),
              ],
            ),
            ref.watch(getAllCategoriesProvider).when(
                  data: (data) {
                    if (data.isNotEmpty) {
                      return DropdownButton(
                        value: data.first.id,
                        items: data
                            .map((e) => DropdownMenuItem(
                                value: e.id, child: Text(e.name)))
                            .toList(),
                        onChanged: (value) {},
                      );
                    } else {
                      // Handle the case when data is empty.
                      return const SizedBox.shrink();
                    }
                  },
                  error: (error, stackTrace) => Text(error.toString()),
                  loading: () => const CircularProgressIndicator(),
                ),
            // DropdownButton(
            //   items: ref.watch(getAllCategoriesProvider).when(
            //         data: (data) {
            //           return data
            //               .map((e) => DropdownMenuItem(
            //                   value: e.id, child: Text(e.name)))
            //               .toList();
            //         },
            //         error: (error, stackTrace) =>
            //             [DropdownMenuItem(child: Text(error.toString()))],
            //         loading: () =>
            //             [const DropdownMenuItem(child: Text('Loading'))],
            //       ),
            //   onChanged: (value) {},
            // ),
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
                        print(stackTrace);
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
