import 'package:flutter_riverpod/flutter_riverpod.dart';

final contentIndexNotifierProvider =
    NotifierProvider<ContentNotifier, int>(ContentNotifier.new);

class ContentNotifier extends Notifier<int> {
  @override
  build() {
    return 0;
  }

  void selectContent({required int selectedContent}) {
    state = selectedContent;
  }

  void increaseIndex() {
    state++;
  }
}
