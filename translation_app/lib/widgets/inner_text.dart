import 'package:flutter/cupertino.dart';

import '../util/constants.dart';
import '../utils.dart';

class InnerText extends StatelessWidget {
  final String text;

  final double? fontSize;

  final Color color;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;

  const InnerText(
      {super.key,
      required this.text,
      this.fontSize = 16,
      this.color = AppColors.dark,
      this.fontWeight = FontWeight.normal,
      this.textAlign = TextAlign.start});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: SafeGoogleFont(
        'Montserrat',
        fontSize: fontSize,
        fontWeight: fontWeight,
        height: 1.2175,
        color: color,
      ),
    );
  }
}
