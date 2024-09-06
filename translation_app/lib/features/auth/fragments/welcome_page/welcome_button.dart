import 'package:flutter/cupertino.dart';

import '../../../../widgets/button.dart';
import '../../../../widgets/enums/button_type.dart';
import '../../../../widgets/enums/fragment_size.dart';
import '../../../../widgets/inner_text.dart';

class WelcomeButton extends StatelessWidget {
  final Widget icon;
  final String text;
  final ButtonType type;
  final void Function() onPressed;

  const WelcomeButton(
      {super.key,
      required this.icon,
      required this.text,
      required this.onPressed,
      this.type = ButtonType.secondary});

  @override
  Widget build(BuildContext context) {
    return Button(
        size: FragmentSize.large,
        type: type,
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Row(
            children: [
              icon,
              Expanded(
                  child: InnerText(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                text: text,
                textAlign: TextAlign.center,
              )),
              Image.asset(
                'assets/page-1/images/icon-arrow-right-1-XUY.png',
                width: 20,
                height: 15,
              ),
            ],
          ),
        ));
  }
}
