import 'package:culinary_course/src/core/constants/constants.dart';
import 'package:culinary_course/src/core/helper/failure.dart';
import 'package:culinary_course/src/core/helper/typedefs.dart';
import 'package:culinary_course/src/features/auth/provider/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  return HomeRepository(ref: ref);
});

// final getFeaturedProvider = FutureProvider<Course>((ref) async {
//   print("Api Called");
//   return ref.watch(homeRepositoryProvider).getFeatured();
// });

class HomeRepository {
  final Ref ref;

  HomeRepository({required this.ref});

  FutureEither<http.Response> getFeatured() async {
    try {
      print("Api callllllled");

      final user = ref.watch(userDataProvider.select((value) => value.token));
      final uri = Uri.parse("$baseUrl/api/v1/courses/featured");

      final http.Response response = await http.get(uri, headers: {
        "Content-Type": "application/json",
        "x-auth-token": user,
      });

      return right(response);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
