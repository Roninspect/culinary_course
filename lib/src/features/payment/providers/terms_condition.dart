import 'package:flutter_riverpod/flutter_riverpod.dart';

final termsConditionNotifierProvider =
    NotifierProvider<TermsConditionNotifier, bool>(TermsConditionNotifier.new);

class TermsConditionNotifier extends Notifier<bool> {
  @override
  build() {
    return false;
  }

  void check(bool value) {
    state = value;
  }
}
