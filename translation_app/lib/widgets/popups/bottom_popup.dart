import 'package:flutter/material.dart';

import '../containers/accent_container.dart';

class BottomPopup {
  static showPopup(BuildContext context, Widget title, Widget child) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        builder: (context) {
          return AccentContainer(
            height: 300,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 10, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: title,
                      )),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: SizedBox(
                          height: 18,
                          child: Image.asset(
                            'assets/page-1/images/x.png',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                child
              ],
            ),
          );
        });
  }
}
