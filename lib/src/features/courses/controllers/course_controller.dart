import 'dart:convert';
import 'package:culinary_course/src/core/utility/error_handling.dart';
import 'package:culinary_course/src/core/utility/error_snackbar.dart';
import 'package:culinary_course/src/features/courses/repository/course.repository.dart';
import 'package:culinary_course/src/models/category.dart';
import 'package:culinary_course/src/models/course.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'course_controller.g.dart';

@Riverpod(keepAlive: true)
courseController(CourseControllerRef ref) {
  return CourseController(
      courseRepository: ref.watch(courseRepositoryProvider));
}

@Riverpod(keepAlive: true)
Future<List<Category>> getAllCategories(GetAllCategoriesRef ref) {
  return ref.watch(courseControllerProvider).getAllCategories();
}

@Riverpod(keepAlive: true)
Future<List<Course>> getCoursesByCategories(GetCoursesByCategoriesRef ref,
    {required String category, required BuildContext context}) {
  return ref
      .watch(courseControllerProvider)
      .getCoursesByCategories(category: category, context: context);
}

class CourseController {
  final CourseRepository _courseRepository;

  CourseController({required CourseRepository courseRepository})
      : _courseRepository = courseRepository;

  Future<List<Category>> getAllCategories() async {
    List<Category> categories = [];
    final res = await _courseRepository.getCategories();

    res.fold((l) => print(l.message), (r) {
      List<dynamic> categoriesList = jsonDecode(r.body);
      categories = categoriesList.map((e) => Category.fromMap(e)).toList();
    });
    return categories;
  }

  Future<List<Course>> getCoursesByCategories(
      {required String category, required BuildContext context}) async {
    List<Course> courses = [];
    final res =
        await _courseRepository.getCoursesByCategories(category: category);

    res.fold(
        (l) => errorSnackBar(context: context, text: l.message),
        (r) => httpErrorHandle(
              response: r,
              context: context,
              onSuccess: () {
                List<dynamic> coursesList = jsonDecode(r.body);
                courses = coursesList.map((e) => Course.fromMap(e)).toList();
              },
            ));
    return courses;
  }
}
