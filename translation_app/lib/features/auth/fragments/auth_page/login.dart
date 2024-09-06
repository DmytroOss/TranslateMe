import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../services/auth_service.dart';
import '../../../../services/user_service.dart';
import '../../../../util/constants.dart';
import '../../../../widgets/button.dart';
import '../../../../widgets/containers/padded_container.dart';
import '../../../../widgets/inner_text.dart';
import '../../../../widgets/input/text_input.dart';
import 'error_popup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _showPassword = false;
  String? errorMessage = '';
  User? user = AuthService().currentUser;

  Future<void> signInWithEmailAndPassword() async {
    try {
      await AuthService().signInWithEmailAndPass(
          email: _emailController.text, password: _passwordController.text);
      setState(() {
        user = AuthService().currentUser;
      });
    } on FirebaseAuthException catch (e) {
      errorMessage = e.message;
    }
  }

  Future<List<User>> retrieveAllUsers() async {
    List<User> users = UserService().retrieveAllUsers() as List<User>;
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return PaddedContainer(
      padding: 30,
      child: Column(
        children: [
          TextInput(
              label: "Email",
              hintText: "translateMe@xample.com",
              prefix: const Icon(Icons.email_rounded),
              controller: _emailController),
          const SizedBox(
            height: 15,
          ),
          TextInput(
              label: "Password",
              hintText: "password123",
              prefix: const Icon(Icons.lock),
              isObscure: _showPassword,
              suffix: IconButton(
                  icon: Icon(
                      _showPassword ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _showPassword = !_showPassword;
                    });
                  }),
              controller: _passwordController),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/password-change-request");
                  },
                  child: const InnerText(
                    text: "forgot password?",
                    fontSize: 14,
                    color: AppColors.gray,
                  )),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Button(
                  onPressed: () {
                    errorMessage = '';
                    signInWithEmailAndPassword().then((value) => {
                          if (errorMessage!.isEmpty)
                            {Navigator.pushNamed(context, "/home")}
                          else
                            {ErrorPopup().show(context)}
                        });
                  },
                  child: const InnerText(
                    text: "Sign In",
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
