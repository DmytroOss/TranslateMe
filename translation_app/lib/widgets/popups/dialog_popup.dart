import 'package:flutter/material.dart';

import '../../util/constants.dart';


class DialogPopup {
  static Future showPopup(BuildContext context, Widget title, Widget content,
      List<Widget> actions) {
    return showDialog(
        context: context,
        builder: (context) => Dialog(
              insetPadding: const EdgeInsets.all(8),
              shadowColor: AppColors.accent,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
              child: Container(
                decoration: const BoxDecoration(
                    color: AppColors.light,
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.dark,
                        spreadRadius: 0.1,
                        blurRadius: 6,
                        offset: Offset(0, 0),
                      ),
                    ]),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Wrap(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          title,
                        ],
                      ),
                      content,
                      Row(
                        children: actions,
                      )
                    ],
                  ),
                ),
              ),
            ));
  }
}
