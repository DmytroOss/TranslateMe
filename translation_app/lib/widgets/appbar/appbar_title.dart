import 'package:flutter/cupertino.dart';

import '../inner_text.dart';

class AppbarTitle extends StatelessWidget {
  final String text;

  const AppbarTitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return InnerText(
      text: text,
      fontSize: 24,
      fontWeight: FontWeight.w500,
    );
  }
}
