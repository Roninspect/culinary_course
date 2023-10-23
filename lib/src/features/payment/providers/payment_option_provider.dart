import 'package:flutter_riverpod/flutter_riverpod.dart';

enum PaymentState {
  creditCard,
  bkash,
}

final paymentOptionNotifierProvider =
    NotifierProvider<AuthScreenNotifier, PaymentState>(AuthScreenNotifier.new);

class AuthScreenNotifier extends Notifier<PaymentState> {
  @override
  build() {
    return PaymentState.creditCard;
  }

  void changePaymentOption(PaymentState paymentState) {
    state = paymentState;
  }
}
