import 'package:culinary_course/src/core/utility/error_handling.dart';
import 'package:culinary_course/src/core/utility/error_snackbar.dart';
import 'package:culinary_course/src/features/auth/provider/user_provider.dart';
import 'package:culinary_course/src/features/auth/repositories/auth_repository.dart';
import 'package:culinary_course/src/features/cart/repository/cart_repository.dart';
import 'package:culinary_course/src/features/courses/widgets/course_card.dart';
import 'package:culinary_course/src/models/course.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cartControllerProvider =
    StateNotifierProvider<CartController, bool>((ref) {
  return CartController(cartRepository: ref.watch(cartRepositoryProvider));
});

class CartController extends StateNotifier<bool> {
  final CartRepository _cartRepository;
  CartController({required CartRepository cartRepository})
      : _cartRepository = cartRepository,
        super(false);

  Future<void> addToCart(
      {required String courseId,
      required BuildContext context,
      required Course course,
      required WidgetRef ref}) async {
    state = true;
    final res = await _cartRepository.addToCart(courseId: courseId);
    
    res.fold(
      (l) => errorSnackBar(context: context, text: l.message),
      (r) => httpErrorHandle(
        response: r,
        context: context,
        onSuccess: () {
          ref.read(userDataProvider.notifier).addToCart(course: course);
           state = false;          
        },
      ),
    );
  }

  Future<void> removeFromCart(
      {required String courseId,
      required BuildContext context,
        required Course course,
      required WidgetRef ref}) async {
    state = true;
    final res = await _cartRepository.removeFromCart(courseId: courseId);

    res.fold(
      (l) => errorSnackBar(context: context, text: l.message),
      (r) => httpErrorHandle(
        response: r,
        context: context,
        onSuccess: () {
     ref.read(userDataProvider.notifier).removeFromCart( course.id);
           state = false; 
   
        },
      ),
    );
  }
}
