import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../../models/user.dart' as user_model;
import '../../../../services/auth_service.dart';
import '../../../../services/user_service.dart';
import '../../../../widgets/button.dart';
import '../../../../widgets/containers/padded_container.dart';
import '../../../../widgets/inner_text.dart';
import '../../../../widgets/input/text_input.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _showPassword = false;
  String? errorMessage = '';
  AuthService authService = AuthService();
  late User? user;

  Future<void> createUserWithEmailAndPassword() async {
    user = authService.currentUser;
    await authService.createUserWithEmailAndPass(
        email: _emailController.text, password: _passwordController.text);
    createUser();
  }

  createUser() async {
    UserService().createUser(
        user: user_model.UserDTO(
            email: _emailController.text, username: _usernameController.text));
  }

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

  @override
  Widget build(BuildContext context) {
    return PaddedContainer(
      padding: 30,
      child: Column(
        children: [
          TextInput(
              label: "Username",
              hintText: "translate me",
              prefix: const Icon(Icons.person_rounded),
              controller: _usernameController),
          const SizedBox(
            height: 15,
          ),
          TextInput(
              label: "Email",
              hintText: "translate@xample.com",
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
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Expanded(
                child: Button(
                  onPressed: () {
                    createUserWithEmailAndPassword()
                        .then((value) => {signInWithEmailAndPassword()})
                        .then((value) => {
                              if (errorMessage!.isEmpty)
                                {Navigator.pushNamed(context, '/home')}
                            });
                  },
                  child: const InnerText(
                    text: "Sign Up",
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
