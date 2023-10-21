import 'package:culinary_course/src/core/utility/error_handling.dart';
import 'package:culinary_course/src/core/utility/error_snackbar.dart';
import 'package:culinary_course/src/features/auth/provider/user_provider.dart';
import 'package:culinary_course/src/features/wishlist/repository/wishlist_repository.dart';
import 'package:culinary_course/src/models/course.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final wishControllerProvider =
    StateNotifierProvider<WishlistController, bool>((ref) {
  return WishlistController(
      wishlistRepository: ref.watch(wishlistRepositoryProvider));
});

class WishlistController extends StateNotifier<bool> {
  final WishlistRepository _wishlistRepository;
  WishlistController({required WishlistRepository wishlistRepository})
      : _wishlistRepository = wishlistRepository,
        super(false);

  Future<void> addToWishlist(
      {required String courseId,
      required BuildContext context,
      required Course course,
      required WidgetRef ref}) async {
    state = true;
    final res = await _wishlistRepository.addWishlist(courseId: courseId);

    res.fold(
      (l) => errorSnackBar(context: context, text: l.message),
      (r) => httpErrorHandle(
        response: r,
        context: context,
        onSuccess: () {
          print("success");
          ref.read(userDataProvider.notifier).addToWishlist(course: course);
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
    final res =
        await _wishlistRepository.removeFromWishlist(courseId: courseId);

    res.fold(
      (l) => errorSnackBar(context: context, text: l.message),
      (r) => httpErrorHandle(
        response: r,
        context: context,
        onSuccess: () {
          ref.read(userDataProvider.notifier).removeFromWishlist(course.id);
          state = false;
        },
      ),
    );
  }
}
