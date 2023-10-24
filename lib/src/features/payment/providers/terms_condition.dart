import 'package:flutter_riverpod/flutter_riverpod.dart';

final termsConditionNotifierProvider =
    NotifierProvider.autoDispose<TermsConditionNotifier, bool>(
        TermsConditionNotifier.new);

class TermsConditionNotifier extends AutoDisposeNotifier<bool> {
  @override
  build() {
    return false;
  }

  void check(bool value) {
    state = value;
  }
}
