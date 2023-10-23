import 'package:culinary_course/src/features/auth/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/colors.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  dynamic email;
  dynamic pass;
  loginUser() async {
    if (loginFormKey.currentState!.validate()) {
      loginFormKey.currentState!.save();

      //** login user function */

      ref.read(authRepositoryProvider.notifier).signInUser(
            context: context,
            email: email,
            password: pass,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: loginFormKey,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Email",
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: primaryColor),
                    ),
                  ),
                  onSaved: (emailVal) {
                    email = emailVal;
                  },
                  validator: (emailVal) {
                    bool result = emailVal!.contains(
                      RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"),
                    );
                    return result ? null : "enter a valid Email";
                  }),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "Password",
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: primaryColor),
                  ),
                ),
                onSaved: (passVal) {
                  pass = passVal;
                },
                validator: (passVal) {
                  return passVal!.length >= 6
                      ? null
                      : "Password must be greater than 6";
                },
              ),
              Row(
                children: [
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      // context.pushNamed(AppRoutes.forgotPassword.name);
                    },
                    child: const Text("Forgot Password?"),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                //* increase the size of the button
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(220, 50),
                  // backgroundColor: greenColor,
                ),
                onPressed: () async {
                  loginUser();
                },
                child: const Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
