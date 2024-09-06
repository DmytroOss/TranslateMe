import 'package:flutter/material.dart';

import '../../models/translation.dart';
import '../../widgets/containers/padded_container.dart';
import '../../widgets/inner_text.dart';

class TranslationInfo extends StatelessWidget {
  final Translation translation;

  const TranslationInfo({super.key, required this.translation});

  @override
  Widget build(BuildContext context) {
    return PaddedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(),
          InnerText(
            text: translation.translationDTO!.translationLanguage,
            fontWeight: FontWeight.bold,
          ),
          InnerText(text: translation.translationDTO!.translationText),
          const SizedBox(
            width: 20,
            height: 40,
          ),
          InnerText(
              text: translation.translationDTO!.translatedToLanguage,
              fontWeight: FontWeight.bold,
          ),
          InnerText(text: translation.translationDTO!.translatedText),
        ],
      ),
    );
  }
}
