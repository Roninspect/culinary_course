import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CouponCard extends ConsumerWidget {
  const CouponCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 50,
      width: 370,
      decoration: BoxDecoration(
          color: const Color.fromARGB(179, 230, 228, 228),
          border: Border.all(width: 0.5, color: Colors.black45),
          borderRadius: BorderRadius.circular(20)),
      child: const Center(
          child: Text(
        "Have a coupon? Click here to enter your code",
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w500,
        ),
      )),
    );
  }
}
