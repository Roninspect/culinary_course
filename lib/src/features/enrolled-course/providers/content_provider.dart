import 'package:culinary_course/src/models/course.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final contentNotifierProvider =
    NotifierProvider<ContentNotifier, List<Content>>(ContentNotifier.new);

class ContentNotifier extends Notifier<List<Content>> {
  @override
  build() {
    return [];
  }

  void selectContent({required List<Content> selectedContent}) {
    state = selectedContent;
  }
}
