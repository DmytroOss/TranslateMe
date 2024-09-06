import 'package:flutter/material.dart';

import '../../util/constants.dart';
import '../inner_text.dart';

class Appbar {
  static createBannerAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.accent,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Row(
          children: [
            SizedBox(
              width: 50,
              height: 56,
              child: Image.asset('assets/page-1/images/logo.png'),
            ),
            const SizedBox(
              width: 10,
            ),
            const InnerText(
              text: 'TranslateMe',
              fontSize: 32,
              color: Color.fromRGBO(235, 235, 235, 1),
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),
    );
  }

  static createEmptyAppBar() {
    return PreferredSize(
        preferredSize: const Size(0, 0),
        child: AppBar(
          backgroundColor: AppColors.accent,
        ));
  }

  static createAppBar({
    required BuildContext context,
    required Widget title,
  }) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.accent,
            borderRadius: BorderRadius.circular(50),
          ),
          child: const BackButton(
            color: AppColors.dark,
          ),
        ),
      ),
      titleSpacing: 8,
      title: title,
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}
