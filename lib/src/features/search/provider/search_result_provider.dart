import 'dart:async';

import 'package:culinary_course/src/features/search/controller/search_controller.dart';
import 'package:culinary_course/src/features/search/repository/search_repository.dart';
import 'package:culinary_course/src/models/course.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_result_provider.g.dart';

// final searchResultNotifierProvider =
//     NotifierProvider<SearchResultNotifier, List<Course>>(
//         SearchResultNotifier.new);

// class SearchResultNotifier extends Notifier<List<Course>> {
//   @override
//   build() {
//     return [];
//   }

//   void searchCourseByTitle({required String query}) async {
//     state = await ref
//         .watch(searchRepositoryProvider)
//         .searchCourseByTitle(query: query);
//   }
// }

@riverpod
class SearchResult extends _$SearchResult {
  @override
  FutureOr<List<Course>> build() {
    return [];
  }

  Future<void> searchCourseByTitle({required String query}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() =>
        ref.watch(searchRepositoryProvider).searchCourseByTitle(query: query));
  }
}
