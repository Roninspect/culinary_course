import 'package:culinary_course/src/models/course.dart';
import 'package:culinary_course/src/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userDataProvider = NotifierProvider<UserData, User>(UserData.new);

class UserData extends Notifier<User> {
  @override
  build() {
    return User(
        id: "",
        name: "",
        email: "",
        isPaid: false,
        number: "",
        password: "",
        token: "",
        cart: [],
        wishlist: []);
  }

  void setUser({required User userModel}) {
    state = userModel;
  }

  void updateuser({required User userModel}) {
    state = userModel;
  }

  void addToCart({required Course course}) {
    final updatedUser = state.copyWith(cart: [...state.cart, course]);

    state = updatedUser;
  }

  void removeFromCart(String courseId) {
    // Again, our state is immutable. So we're making a new list instead of
    // changing the existing list.

    final updatedCart = [
      for (final course in state.cart)
        if (course.id != courseId) course,
    ];

    final updatedUser = state.copyWith(cart: updatedCart);
    state = updatedUser;
  }

  void addToWishlist({required Course course}) {
    final updatedUser = state.copyWith(wishlist: [...state.wishlist, course]);

    state = updatedUser;
  }

  void removeFromWishlist(String courseId) {
    // Again, our state is immutable. So we're making a new list instead of
    // changing the existing list.

    final updatedWishlist = [
      for (final course in state.wishlist)
        if (course.id != courseId) course,
    ];

    final updatedUser = state.copyWith(wishlist: updatedWishlist);
    state = updatedUser;
  }
}
