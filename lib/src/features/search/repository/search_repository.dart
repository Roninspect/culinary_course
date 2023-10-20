import 'dart:convert';

import 'package:culinary_course/src/core/constants/constants.dart';
import 'package:culinary_course/src/models/course.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

final searchRepositoryProvider = Provider<SearchRepository>((ref) {
  return SearchRepository();
});

class SearchRepository {
  Future<List<Course>> searchCourseByTitle(String? category,
      {required String query}) async {
    try {
      List<Course> searchResults = [];
      const FlutterSecureStorage secureStorage = FlutterSecureStorage();
      final String? token = await secureStorage.read(key: "x-auth-token");
      final Uri url = category == null
          ? Uri.parse("$baseUrl/api/v1/courses/testsearch/$query")
          : Uri.parse("$baseUrl/api/v1/courses/testsearch/$query/$category");
      final http.Response response = await http.get(url, headers: {
        "Content-Type": "application/json",
        "x-auth-token": token!,
      });

      List<dynamic> dynamicRes = jsonDecode(response.body);
      searchResults = dynamicRes.map((e) => Course.fromMap(e)).toList();

      return searchResults;
    } catch (e) {
      rethrow;
    }
  }
}
