import 'package:flutter/material.dart';

import '../../util/constants.dart';
import '../inner_text.dart';
import 'app_input_decoration.dart';


class TextInput extends StatelessWidget {
  final String label;
  final String hintText;

  final bool isObscure;
  final bool isDisabled;

  final Widget? prefix;
  final Widget? suffix;

  final TextEditingController controller;

  const TextInput({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.isObscure = false,
    this.isDisabled = false,
    this.prefix,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(left: 12, bottom: 6),
            child: InnerText(
              text: label,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        TextField(
          cursorColor: AppColors.dark,
          enabled: !isDisabled,
          controller: controller,
          obscureText: isObscure,
          autocorrect: isObscure,
          enableSuggestions: isObscure,
          decoration: AppInputDecoration(
            hintText,
            prefix,
            suffix,
          ),
        ),
      ],
    );
  }
}
