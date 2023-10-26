import 'package:culinary_course/src/core/utility/error_handling.dart';
import 'package:culinary_course/src/core/utility/error_snackbar.dart';
import 'package:culinary_course/src/features/auth/provider/user_provider.dart';
import 'package:culinary_course/src/features/auth/repositories/auth_repository.dart';
import 'package:culinary_course/src/features/payment/repository/payment_repository.dart';
import 'package:culinary_course/src/models/course.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final paymentControllerProvider =
    StateNotifierProvider<PaymentController, bool>((ref) {
  return PaymentController(
      paymentRepository: ref.watch(paymentRepositoryProvider));
});

class PaymentController extends StateNotifier<bool> {
  final PaymentRepository _paymentRepository;
  PaymentController({required PaymentRepository paymentRepository})
      : _paymentRepository = paymentRepository,
        super(false);

  Future<void> enrollCourse(
      {required String courseId,
      required BuildContext context,
      required Course course,
      required WidgetRef ref}) async {
    state = true;
    final res = await _paymentRepository.enrollCourse(courseId: courseId);

    res.fold(
      (l) => errorSnackBar(context: context, text: l.message),
      (r) => httpErrorHandle(
        response: r,
        context: context,
        onSuccess: () {
          ref.read(authRepositoryProvider.notifier).getUserData();
          ref.read(userDataProvider.notifier).emptycart();
          ref.read(userDataProvider.notifier).emptyWishlist(courseId);
        },
      ),
    );

    state = false;
  }
}
