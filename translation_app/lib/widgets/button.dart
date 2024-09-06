import 'package:flutter/material.dart';


import '../util/constants.dart';
import 'enums/button_type.dart';
import 'enums/fragment_radius.dart';
import 'enums/fragment_size.dart';

class Button extends StatelessWidget {
  final Widget child;
  final void Function() onPressed;

  final Icon? prefixIcon;
  final Icon? suffixIcon;

  final bool isDisabled;

  final ButtonType type;
  final FragmentSize size;
  final FragmentRadius radius;

  Button(
      {super.key,
      required this.child,
      required this.onPressed,
      this.prefixIcon,
      this.suffixIcon,
      this.isDisabled = false,
      this.type = ButtonType.primary,
      this.size = FragmentSize.normal,
      this.radius = FragmentRadius.full});

  final background = {
    ButtonType.primary: AppColors.accent,
    ButtonType.secondary: AppColors.light,
  };

  final constraints = {
    FragmentSize.large: const BoxConstraints(minWidth: 170, minHeight: 60),
    FragmentSize.normal: const BoxConstraints(minWidth: 170, minHeight: 40),
    FragmentSize.small: const BoxConstraints(minWidth: 120, minHeight: 40),
  };

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: constraints[size] ??
          const BoxConstraints(minWidth: 170, minHeight: 40),
      child: TextButton(
          onPressed: isDisabled ? () {} : onPressed,
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: radius.radius,
                side: const BorderSide(
                  color: AppColors.accentDark,
                  style: BorderStyle.solid,
                  width: 0,
                )),
            backgroundColor: background[type],
          ),
          child: child),
    );
  }
}
