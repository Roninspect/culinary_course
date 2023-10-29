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

  void changeCurriculum({required int index}) {
    ref
        .watch(singleCurriculumNotifierProvider.notifier)
        .selectCurriculum(currentCurriculum: state[index]);
  }
}

final singleCurriculumNotifierProvider =
    NotifierProvider<SingleCurriculumNotifier, Curriculum?>(
        SingleCurriculumNotifier.new);

class SingleCurriculumNotifier extends Notifier<Curriculum?> {
  @override
  build() {
    return null;
  }

  void selectCurriculum({required Curriculum currentCurriculum}) {
    state = currentCurriculum;
  }

  // void changeContent({required int index}) {
  //   ref
  //       .watch(contentNotifierProvider.notifier)
  //       .selectContent(selectedContent: state!.content);
  // }
}
