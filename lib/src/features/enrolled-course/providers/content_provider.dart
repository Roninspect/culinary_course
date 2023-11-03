import 'package:culinary_course/src/features/enrolled-course/providers/content_index_provider.dart';
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

final singleContentNotifierProvider =
    NotifierProvider<SingleContentNotifier, Content?>(
        SingleContentNotifier.new);

class SingleContentNotifier extends Notifier<Content?> {
  @override
  build() {
    return null;
  }

  void selectContent({required Content currentContent}) {
    state = currentContent;
  }
}
