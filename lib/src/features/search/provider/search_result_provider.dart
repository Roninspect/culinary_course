import 'dart:async';
import 'package:culinary_course/src/features/search/repository/search_repository.dart';
import 'package:culinary_course/src/models/course.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_result_provider.g.dart';

@riverpod
class SearchResult extends _$SearchResult {
  @override
  FutureOr<List<Course>> build() {
    return [];
  }

  Future<void> searchCourseByTitle(
    String? category, {
    required String query,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => category == null
        ? ref
            .watch(searchRepositoryProvider)
            .searchCourseByTitle(query: query, null)
        : ref
            .watch(searchRepositoryProvider)
            .searchCourseByTitle(query: query, category));
  }
}
