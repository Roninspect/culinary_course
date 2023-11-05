import 'package:culinary_course/src/core/enums/watch_enum.dart';
import 'package:culinary_course/src/features/enrolled-course/providers/content_provider.dart';
import 'package:culinary_course/src/models/course.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final curriculumNotifierProvider =
    NotifierProvider<CurriculumNotifier, List<Curriculum>>(
        CurriculumNotifier.new);

class CurriculumNotifier extends Notifier<List<Curriculum>> {
  @override
  build() {
    return [];
  }

  void selectCurriculum({required List<Curriculum> selectedCurriculum}) {
    state = selectedCurriculum;
  }

  void markAsDone({
    required int currentCurriculumIndex,
    required int currentContentIndex,
  }) {
    state = List<Curriculum>.from(state.map((curriculum) {
      if (state.indexOf(curriculum) == currentCurriculumIndex) {
        return curriculum.copyWith(
          content: List<Content>.from(curriculum.content.map((content) {
            if (curriculum.content.indexOf(content) == currentContentIndex) {
              return content.copyWith(
                isWatched: WatchState.WATCHED.name,
              );
            }
            return content;
          })),
        );
      }
      return curriculum;
    }));
  }
}
