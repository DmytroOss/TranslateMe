import 'user.dart';

class SavedWord {
  String? key;
  SavedWordDTO? savedWordDTO;

  SavedWord({required this.key, required this.savedWordDTO});
}

class SavedWordDTO {
  late final String translation;
  late final String userKey;
  late final String explanation;

  SavedWordDTO(
      {
      required this.translation,
      required this.userKey,
      required this.explanation
      });

  SavedWordDTO.fromJson(Map<dynamic, dynamic> json) {
    translation = json['translation'];
    userKey = json['userKey'];
    explanation = json['explanation'];
  }

  toJson() {
    return {
      'translation': translation,
      'userKey': userKey,
      'explanation': explanation
    };
  }
}
