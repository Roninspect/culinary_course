import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final tokenNotifierProvider =
    NotifierProvider<TokenNotifier, String?>(TokenNotifier.new);

class TokenNotifier extends Notifier<String?> {
  @override
  build() {
    return "";
  }

  void setToken() async {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    final String? token = await secureStorage.read(key: "x-auth-token");

    state = token;
  }
}
