import 'dart:core';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  static const _storage = FlutterSecureStorage();

  static const String key = "x-auth-token";

  static Future setToken({required String token}) async =>
      await _storage.write(key: key, value: token);

  static Future<String?> getToken() async => await _storage.read(key: key);
}
