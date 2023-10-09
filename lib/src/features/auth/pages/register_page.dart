import 'package:culinary_course/src/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../repositories/auth_repository.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final GlobalKey<FormState> _registerKey = GlobalKey<FormState>();
  bool _passwordVisible = true;

  var name;
  var email;
  var pass;
  var phone;

  @override
  Widget build(BuildContext context) {
    // final String selectedDistrict =
    //     ref.watch(registerDistrictSelectingNotifierProvider);
    void validRegister() async {
      if (_registerKey.currentState!.validate()) {
        _registerKey.currentState!.save();
        ref.read(authRepositoryProvider.notifier).signUpUser(
              name: name,
              email: email,
              number: phone,
              password: pass,
              context: context,
            );
      }
    }

    // bool isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: AppBar(),
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0).copyWith(top: 20, left: 20),
                child: const Text('Register',
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 40),
              Form(
                  key: _registerKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextFormField(
                            decoration: const InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: primaryColor),
                                ),
                                hintText: "Email",
                                border: OutlineInputBorder()),
                            onSaved: (emailVal) {
                              email = emailVal;
                            },
                            validator: (emailVal) {
                              bool result = emailVal!.contains(
                                RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"),
                              );
                              return result ? null : "Enter a Valid Email";
                            }),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: primaryColor),
                              ),
                              hintText: " Your Name",
                              border: OutlineInputBorder()),
                          onSaved: (nameVal) {
                            name = nameVal;
                          },
                          validator: (nameVal) {
                            return nameVal!.isNotEmpty
                                ? null
                                : "Please Enter Your Name";
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: primaryColor),
                              ),
                              hintText: " Your Phone Number",
                              border: OutlineInputBorder()),
                          onSaved: (phoneVal) {
                            phone = phoneVal;
                          },
                          validator: (phoneVal) {
                            return phoneVal!.length <= 11
                                ? null
                                : "Invalid Number";
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextFormField(
                          obscureText: _passwordVisible,
                          decoration: InputDecoration(
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: primaryColor),
                            ),
                            hintText: "Password",
                            border: const OutlineInputBorder(),
                            suffixIcon: IconButton(
                              icon: Icon(
                                // Based on passwordVisible state choose the icon
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                // Update the state i.e. toogle the state of passwordVisible variable
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),
                          ),
                          onSaved: (passVal) {
                            pass = passVal;
                          },
                          validator: (passVal) {
                            return passVal!.length > 6
                                ? null
                                : "Password must be greater than 6";
                          },
                        ),
                      ),
                    ],
                  )),
              const SizedBox(height: 20),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(250, 60),
                      backgroundColor: Colors.black),
                  onPressed: () => validRegister(),
                  child:
                      // isLoading
                      //     ? const Center(
                      //         child: CircularProgressIndicator(),
                      //       )
                      //     :
                      const Text(
                    "Register",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: primaryColor),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Center(child: SizedBox(width: 220, child: FlutterLogo())),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an Account?"),
                  InkWell(
                    onTap: () {
                      context.pop();
                    },
                    child: const Text(
                      ' Sign In',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
