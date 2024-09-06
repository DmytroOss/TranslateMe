
import 'package:translation_app/models/user.dart';

class Translation {
  String? key;
  TranslationDTO? translationDTO;

  Translation({required this.key, required this.translationDTO});
}


class TranslationDTO {
  late final String translationText;
  late final String translatedText;
  late final String translationLanguage;
  late final String translatedToLanguage;
  late final String userKey;

  TranslationDTO(
      {required this.translationText,
        required this.translatedText,
        required this.translationLanguage,
        required this.translatedToLanguage,
        required this.userKey});

  TranslationDTO.fromJson(Map<dynamic, dynamic> json) {
    translationText = json['translationText'];
    translatedText = json['translatedText'];
    translationLanguage = json['translationLanguage'];
    translatedToLanguage = json['translatedToLanguage'];
    userKey = json['userKey'];
  }

  toJson() {
    return {
      'translationText': translationText,
      'translatedText': translatedText,
      'translationLanguage': translationLanguage,
      'translatedToLanguage': translatedToLanguage,
      "userKey": userKey
    };
  }
}
