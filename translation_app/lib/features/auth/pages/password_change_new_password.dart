import 'package:flutter/material.dart';
import 'package:translation_app/widgets/translate_banner.dart';

import '../../../widgets/appbar/appbar.dart';
import '../../../widgets/appbar/appbar_title.dart';
import '../../../widgets/button.dart';
import '../../../widgets/containers/padded_container.dart';
import '../../../widgets/inner_text.dart';
import '../../../widgets/input/text_input.dart';

class PasswordChangeNewPassword extends StatefulWidget {
  const PasswordChangeNewPassword({super.key});

  @override
  State<PasswordChangeNewPassword> createState() =>
      _PasswordChangeNewPasswordState();
}

class _PasswordChangeNewPasswordState extends State<PasswordChangeNewPassword> {
  final TextEditingController _passwordController = TextEditingController();
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar.createAppBar(
          context: context, title: const AppbarTitle(text: "Password Reset")),
      body: PaddedContainer(
        padding: 30,
        child: Column(
          children: [
            const TranslateBanner(
                isVertical: true,
                hasShadow: false,
                isCentered: true,
                isTransparent: true),
            const SizedBox(
              height: 15,
            ),
            TextInput(
                label: "Password",
                hintText: "password123",
                prefix: const Icon(Icons.lock),
                isObscure: _showPassword,
                suffix: IconButton(
                    icon: Icon(_showPassword
                        ? Icons.visibility
                        : Icons.visibility_off),
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
                      child: const InnerText(
                        text: "Confirm",
                      ),
                      onPressed: () {}),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
