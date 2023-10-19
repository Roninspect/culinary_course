import 'package:culinary_course/src/core/utility/error_handling.dart';
import 'package:culinary_course/src/core/utility/error_snackbar.dart';
import 'package:culinary_course/src/features/home/repository/home_repository.dart';
import 'package:culinary_course/src/models/course.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_controller.g.dart';

final homeControllerProvider =
    StateNotifierProvider<HomeController, bool>((ref) {
  return HomeController(homeRepository: ref.watch(homeRepositoryProvider));
});

@Riverpod(keepAlive: true)
Future<Course> getFeatured (GetFeaturedRef ref, {required BuildContext context}) {
   return ref.watch(homeControllerProvider.notifier).getFeatured(context);
}


class HomeController extends StateNotifier<bool> {
  final HomeRepository _homeRepository;
  HomeController({required HomeRepository homeRepository})
      : _homeRepository = homeRepository,
        super(false);

  Future<Course> getFeatured(BuildContext context) async {
    Course? course;
    final res = await _homeRepository.getFeatured();

    res.fold(
      (l) => errorSnackBar(context: context, text: l.message),
      (r) => httpErrorHandle(context: context,response: r,onSuccess: () {
        course = Course.fromJson(r.body);
      },),
    );

    return course!;
  }
}
