import 'package:flutter/material.dart';
import 'package:translation_app/features/archieve/translation_info.dart';

import '../../models/translation.dart';
import '../../widgets/appbar/appbar_title.dart';
import '../../widgets/inner_text.dart';
import '../../widgets/popups/bottom_popup.dart';

class TranslationWidget extends StatelessWidget {
  final Translation translation;

  const TranslationWidget({super.key, required this.translation});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 23),
      child: GestureDetector(
        onTap: () {
          BottomPopup.showPopup(
              context,
              AppbarTitle(text: "${translation.translationDTO!.translationText} - ${translation.translationDTO!.translatedText}"),
              TranslationInfo(
                translation: translation,
              ));
        },
        child: InnerText(
          text: translation.translationDTO!.translatedText,
          fontSize: 20,
        ),
      ),
    );
  }
}
