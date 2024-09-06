import 'package:flutter/cupertino.dart';

import '../../../../util/constants.dart';
import '../../../../widgets/inner_text.dart';

class WelcomeDivider extends StatelessWidget {
  const WelcomeDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            color: AppColors.gray,
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: InnerText(
            text: "or",
            fontSize: 20,
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            color: AppColors.gray,
          ),
        ),
      ],
    );
  }
}
