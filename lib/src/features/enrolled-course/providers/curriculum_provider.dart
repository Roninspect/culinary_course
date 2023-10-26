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
}
