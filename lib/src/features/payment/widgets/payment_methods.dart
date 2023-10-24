import 'package:culinary_course/src/core/constants/colors.dart';
import 'package:culinary_course/src/features/payment/providers/payment_option_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PaymentMethodOptions extends ConsumerWidget {
  const PaymentMethodOptions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paymentOption = ref.watch(paymentOptionNotifierProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        const Text(
          "Payment Method",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Radio(
            activeColor: const Color(0xff295CAB),
            value: PaymentState.creditCard,
            groupValue: paymentOption,
            onChanged: (value) {
              ref
                  .read(paymentOptionNotifierProvider.notifier)
                  .changePaymentOption(value!);
            },
          ),
          title: const Text(
            "Credit/Debit card",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ),
        paymentOption == PaymentState.creditCard
            ? const Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(
                  "Pay securely by Credit/Debit card, Internet banking through SSLCommerz.",
                  style: TextStyle(fontSize: 17),
                ),
              )
            : const SizedBox.shrink(),
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Radio(
            activeColor: const Color(0xffE3106E),
            value: PaymentState.bkash,
            groupValue: paymentOption,
            onChanged: (value) {
              ref
                  .read(paymentOptionNotifierProvider.notifier)
                  .changePaymentOption(value!);
            },
          ),
          title: const Text(
            "Bkash",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ),
        paymentOption == PaymentState.bkash
            ? const Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(
                  "Pay securely by Mobile through Bkash.",
                  style: TextStyle(fontSize: 17),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
