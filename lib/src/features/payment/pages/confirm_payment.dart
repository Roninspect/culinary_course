// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:culinary_course/src/core/constants/colors.dart';
import 'package:culinary_course/src/core/widgets/custom_button.dart';
import 'package:culinary_course/src/features/auth/provider/user_provider.dart';
import 'package:culinary_course/src/features/payment/providers/payment_option_provider.dart';
import 'package:culinary_course/src/features/payment/providers/terms_condition.dart';
import 'package:culinary_course/src/features/payment/widgets/coupon_card.dart';
import 'package:culinary_course/src/features/payment/widgets/order_listview.dart';
import 'package:culinary_course/src/features/payment/widgets/payment_methods.dart';
import 'package:culinary_course/src/features/payment/widgets/textfield_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PaymentConfirmPage extends ConsumerWidget {
  const PaymentConfirmPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userDataProvider);
    final paymentOption = ref.watch(paymentOptionNotifierProvider);
    bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;

    final TextEditingController nameController =
        TextEditingController(text: user.name);
    final TextEditingController emailController =
        TextEditingController(text: user.email);
    final TextEditingController mobileController =
        TextEditingController(text: user.number);

    num getTotalPrice() {
      num total = 0;

      for (var cart in user.cart) {
        total = cart.price + total;
      }

      return double.parse(total.toStringAsFixed(2));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Confirm Payment"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Your Order",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              //** order listview */
              const OrderListview(),

              Row(
                children: [
                  const Spacer(),
                  Text(
                    "Total: ${getTotalPrice()} BDT",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              //** Coupon */

              const CouponCard(),

              const SizedBox(height: 20),

              //** user information fields */
              const Text(
                "Account Details",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              const TextfieldTitle(title: "Username", isOptional: false),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
              const SizedBox(height: 15),
              const TextfieldTitle(title: "Email Address", isOptional: false),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
              const SizedBox(height: 15),
              const TextfieldTitle(
                  title: "Mobile Number (Optional)", isOptional: true),
              TextField(
                controller: mobileController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),

              //** Payment */
              const PaymentMethodOptions(),

              const SizedBox(height: 10),

              Row(
                children: [
                  Checkbox(
                    value: ref.watch(termsConditionNotifierProvider),
                    onChanged: (value) {
                      ref
                          .read(termsConditionNotifierProvider.notifier)
                          .check(value!);
                    },
                    activeColor: Colors.green,
                  ),
                  const Flexible(
                    child: Text(
                      "I have read and agree to the website Terms & Conditions, Refund and Privacy Policies",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Visibility(
        visible: !keyboardIsOpened,
        child: SizedBox(
          width: 365,
          child: CustomButton(
              height: 50,
              width: 10,
              text: paymentOption == PaymentState.creditCard
                  ? "Checkout using SSLCommerz "
                  : "Checkout Using Bkash",
              onpressed: () {},
              backgroundColor: paymentOption == PaymentState.creditCard
                  ? const Color(0xff295CAB)
                  : const Color(0xffE3106E)),
        ),
      ),
    );
  }
}
