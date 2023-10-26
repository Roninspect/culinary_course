import 'dart:convert';
import 'package:culinary_course/src/core/constants/constants.dart';
import 'package:culinary_course/src/features/auth/provider/user_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import '../../../core/utility/error_handling.dart';
import '../../../core/utility/error_snackbar.dart';
import '../../../models/user_model.dart';
import 'package:http/http.dart' as http;

final authRepositoryProvider =
    StateNotifierProvider<AuthRepository, bool>((ref) {
  return AuthRepository(ref: ref, dio: Dio());
});

class AuthRepository extends StateNotifier<bool> {
  final Ref ref;
  final Dio dio;

  AuthRepository({required this.dio, required this.ref}) : super(false);
  Future<void> signUpUser({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
    required String number,
  }) async {
    try {
      final user = User(
        id: "",
        name: name,
        email: email,
        password: password,
        isPaid: false,
        number: number,
        cart: [],
        wishlist: [],
        enrolled: [],
        token: "",
      );

      final http.Response response = await http.post(
          Uri.parse("$baseUrl/api/v1/user/signup"),
          body: user.toJson(),
          headers: <String, String>{
            "Content-Type": "application/json",
          });
      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          errorSnackBar(
              context: context,
              text: "Account Created, Login With The same Credentials");
          context.pop();
        },
      );
    } catch (e) {
      errorSnackBar(context: context, text: e.toString());
    }
  }

  //* signing in user */

  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      final uri = Uri.parse("$baseUrl/api/v1/user/signIn");

      final http.Response response = await http.post(uri,
          body: jsonEncode({
            "email": email,
            "password": password,
          }),
          headers: <String, String>{"Content-Type": "application/json"});

      User userModel = User.fromJson(response.body);

      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () async {
          // final SharedPreferences prefs = await SharedPreferences.getInstance();

          // await prefs.setString("x-auth-token", userModel.token);

          const FlutterSecureStorage secureStorage = FlutterSecureStorage();
          await secureStorage.write(
              key: "x-auth-token", value: userModel.token);

          ref.read(userDataProvider.notifier).setUser(userModel: userModel);
        },
      );
    } catch (e) {
      errorSnackBar(context: context, text: e.toString());
    }
  }

  //** validate user token and persist user auth state */

  void validateAndgetUserData() async {
    try {
      const FlutterSecureStorage secureStorage = FlutterSecureStorage();
      final String? token = await secureStorage.read(key: "x-auth-token");

      if (token == null) {
        secureStorage.write(key: "x-auth-token", value: "");
      }
      final uri = Uri.parse("$baseUrl/api/v1/user/tokenIsValid");
      final http.Response tokenRes = await http.post(
        uri,
        headers: <String, String>{
          "Content-Type": "application/json",
          "x-auth-token": token!,
        },
      );
      final bool response = jsonDecode(tokenRes.body);

      if (response == true) {
        try {
          final userUri = Uri.parse("$baseUrl/api/v1/user/getUserData");
          http.Response userResponse = await http.get(
            userUri,
            headers: <String, String>{
              "Content-Type": "application/json",
              "x-auth-token": token,
            },
          );

          final userModel = User.fromMap(jsonDecode(userResponse.body));

          ref.read(userDataProvider.notifier).setUser(userModel: userModel);
        } catch (e, stk) {
          print(stk);
          throw Exception(e.toString());
        }
      }
    } catch (e, stk) {
      print(stk);
      throw Exception(e.toString());
    }
  }

  void getUserData() async {
    try {
      const FlutterSecureStorage secureStorage = FlutterSecureStorage();
      final String? token = await secureStorage.read(key: "x-auth-token");
      final userUri = Uri.parse("$baseUrl/api/v1/user/getUserData");
      http.Response userResponse = await http.get(
        userUri,
        headers: <String, String>{
          "Content-Type": "application/json",
          "x-auth-token": token!,
        },
      );

      final userModel = User.fromMap(jsonDecode(userResponse.body));

      ref.read(userDataProvider.notifier).updateuser(userModel: userModel);
    } catch (e, stk) {
      print(ref.read(userDataProvider).wishlist);
      print(stk);
      throw Exception(e.toString());
    }
  }
}
