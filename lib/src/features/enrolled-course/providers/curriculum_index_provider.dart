import 'package:flutter_riverpod/flutter_riverpod.dart';

final curriculumIndexNotifierProvider =
    NotifierProvider<CurricullumNotifier, int>(CurricullumNotifier.new);

class CurricullumNotifier extends Notifier<int> {
  @override
  build() {
    return 0;
  }

  void selectCurriculum({required int selectedContent}) {
    state = selectedContent;
  }

  void increaseIndex() {
    state++;
  }
}
