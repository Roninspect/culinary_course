import 'package:culinary_course/src/core/constants/colors.dart';
import 'package:culinary_course/src/features/courses/controllers/course_controller.dart';
import 'package:culinary_course/src/features/courses/provider/category_selector_provider.dart';
import 'package:culinary_course/src/features/courses/widgets/course_card.dart';
import 'package:culinary_course/src/models/category.dart';
import 'package:culinary_course/src/routes/routes.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CategoriesListView extends ConsumerWidget  {
  const CategoriesListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getAllCategoriesProvider).when(
          data: (categories) => Column(
            children: [
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final Category category = categories[index];

                    final isMatched = ref.watch(
                            categorySelectorNotifierProvider(
                                categories.first.name)) ==
                        category.name;

                    return Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: GestureDetector(
                        onTap: () => ref
                            .read(categorySelectorNotifierProvider(
                                    categories.first.name)
                                .notifier)
                            .selectCategory(category.name),
                        child: Chip(
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isMatched ? Colors.white : Colors.black,
                          ),
                          backgroundColor:
                              isMatched ? primaryColor : Colors.white,
                          label: Text(
                            category.name,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 400,
                child: ref
                    .watch(
                      getCoursesByCategoriesProvider(
                        category: ref.watch(
                                categorySelectorNotifierProvider(
                                    categories.first.name)),context: context
                      ),
                    )
                    .when(
                      data: (courses) => ListView.builder(
                         key: const PageStorageKey<String>('controllerA'),
                        scrollDirection: Axis.horizontal,
                        itemCount: courses.length,
                        itemBuilder: (context, index) {
                          final course = courses[index];
                          return GestureDetector(
                            onTap: () {
                              context.pushNamed(
                                AppRoutes.course.name,
                                pathParameters: {"id": course.id},
                                extra: course,
                              );
                            },
                            child: CourseCard(course: course),
                          );
                        },
                      ),
                      error: (error, stackTrace) {
                        if (foundation.kDebugMode) {
                          // ignore: avoid_print
                          print(stackTrace);
                        }
                        return Text(error.toString());
                      },
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                    ),
              )
            ],
          ),
          error: (error, stackTrace) => Text(error.toString()),
          loading: () => const Center(child: CircularProgressIndicator()),
        );
  }
}
