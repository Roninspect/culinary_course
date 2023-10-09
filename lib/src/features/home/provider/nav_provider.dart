import 'package:flutter_riverpod/flutter_riverpod.dart';

final navNotifierProvider = NotifierProvider<NavNotifier, int>(NavNotifier.new);

class NavNotifier extends Notifier<int> {
  @override
  build() {
    return 0;
  }

  void setIndex({required int index}) {
    state = index;
  }
}
