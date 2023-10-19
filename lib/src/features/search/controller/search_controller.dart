import 'dart:convert';

import 'package:culinary_course/src/core/utility/error_handling.dart';
import 'package:culinary_course/src/core/utility/error_snackbar.dart';
import 'package:culinary_course/src/features/search/repository/search_repository.dart';
import 'package:culinary_course/src/models/course.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_controller.g.dart';

@Riverpod(keepAlive: true)
searchcontroller(SearchcontrollerRef ref) {
  return SearchController(
      searchRepository: ref.watch(searchRepositoryProvider));
}

// @riverpod
// Future<List<Course>> searchCourseByTitle(SearchCourseByTitleRef ref,
//     {required String query, required BuildContext context}) {
//   return ref
//       .watch(searchcontrollerProvider)
//       .searchCourseByTitle(query: query, context: context);
// }

class SearchController {
  final SearchRepository _searchRepository;

  SearchController({required SearchRepository searchRepository})
      : _searchRepository = searchRepository;

  // Future<List<Course>> searchCourseByTitle(
  //     {required String query, required BuildContext context}) async {
  //   List<Course> searchResults = [];
  //   final res = await _searchRepository.searchCourseByTitle(query: query);

  //   res.fold(
  //     (l) => errorSnackBar(context: context, text: l.message),
  //     (r) => httpErrorHandle(
  //       response: r,
  //       context: context,
  //       onSuccess: () {
  //         List<dynamic> dynamicRes = jsonDecode(r.body);
  //         searchResults = dynamicRes.map((e) => Course.fromMap(e)).toList();
  //       },
  //     ),
  //   );

  //   return searchResults;
  // }
}
