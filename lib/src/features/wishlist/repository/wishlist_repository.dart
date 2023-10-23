import 'package:culinary_course/src/core/constants/constants.dart';
import 'package:culinary_course/src/core/helper/failure.dart';
import 'package:culinary_course/src/core/helper/typedefs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;

final wishlistRepositoryProvider = Provider<WishlistRepository>((ref) {
  return WishlistRepository();
});

class WishlistRepository {
  FutureEither<http.Response> addWishlist({required String courseId}) async {
    try {
      const FlutterSecureStorage secureStorage = FlutterSecureStorage();
      final String? token = await secureStorage.read(key: "x-auth-token");
      final http.Response response = await http.post(
          Uri.parse("$baseUrl/api/v1/courses/add-to-wishlist/$courseId"),
          headers: {
            "Content-Type": "application/json",
            "x-auth-token": token!,
          });
      return right(response);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureEither<http.Response> removeFromWishlist(
      {required String courseId}) async {
    try {
      const FlutterSecureStorage secureStorage = FlutterSecureStorage();
      final String? token = await secureStorage.read(key: "x-auth-token");
      final http.Response response = await http.post(
          Uri.parse("$baseUrl/api/v1/courses/remove-from-wishlist/$courseId"),
          headers: {
            "Content-Type": "application/json",
            "x-auth-token": token!,
          });
      return right(response);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
