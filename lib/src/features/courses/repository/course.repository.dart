import 'package:culinary_course/src/core/constants/constants.dart';
import 'package:culinary_course/src/core/helper/failure.dart';
import 'package:culinary_course/src/core/helper/typedefs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;

final courseRepositoryProvider = Provider<CourseRepository>((ref) {
  return CourseRepository();
});

class CourseRepository {
  FutureEither<http.Response> getCategories() async {
    try {
      const FlutterSecureStorage secureStorage = FlutterSecureStorage();
      final String? token = await secureStorage.read(key: "x-auth-token");
      final http.Response response =
          await http.get(Uri.parse("$baseUrl/api/v1/categories"), headers: {
        "Content-Type": "application/json",
        "x-auth-token": token!,
      });
      return right(response);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureEither<http.Response> getCoursesByCategories(
      {required String category}) async {
    try {
      const FlutterSecureStorage secureStorage = FlutterSecureStorage();
      final String? token = await secureStorage.read(key: "x-auth-token");
      final http.Response response = await http
          .get(Uri.parse("$baseUrl/api/v1/courses/all/$category"), headers: {
        "Content-Type": "application/json",
        "x-auth-token": token!,
      });
      return right(response);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
