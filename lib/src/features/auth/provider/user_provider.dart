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
        cart: []);
  }

  void setUser({required User userModel}) {
    state = userModel;
  }
}
