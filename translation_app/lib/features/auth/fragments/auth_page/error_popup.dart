import 'package:flutter/cupertino.dart';

import '../../../../widgets/button.dart';
import '../../../../widgets/enums/fragment_size.dart';
import '../../../../widgets/inner_text.dart';
import '../../../../widgets/popups/dialog_popup.dart';

class ErrorPopup {
  void show(BuildContext context) {
    DialogPopup.showPopup(
        context,
        SizedBox(
          width: 70,
          height: 76,
          child: Image.asset('assets/page-1/images/rectangle-387-ekF.png'),
        ),
        const Column(
          children: [
            SizedBox(
              height: 30,
            ),
            InnerText(
                text:
                    'Email or password is incorrect, please check it and try again'),
            SizedBox(
              height: 30,
            )
          ],
        ),
        [
          Expanded(
            child: Button(
                size: FragmentSize.small,
                child: const InnerText(
                  text: "OK",
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ),
        ]);
  }
}
