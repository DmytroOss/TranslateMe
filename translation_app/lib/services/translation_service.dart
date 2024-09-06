import 'package:firebase_database/firebase_database.dart';

import '../../models/user.dart';
import '../models/translation.dart';

class TranslationService {
  DatabaseReference dbRef = FirebaseDatabase.instance.ref();

  createTranslation({required TranslationDTO translation}) async {
    var obj = dbRef.child('/Translation').push();
    await obj.set(translation.toJson());
    return obj;
  }

  Future<List<Translation>> retrieveTranslationByUser(String userKey) async {
    List<Translation> translations = [];
    DataSnapshot data = await dbRef.child("/Translation").get();
    for (var element in data.children) {
      TranslationDTO dataValue = TranslationDTO.fromJson(element.value as Map);
      Translation translation = Translation(key: element.key, translationDTO: dataValue);
      print(translation.translationDTO!.userKey);
      if (translation.translationDTO!.userKey == userKey) {
        translations.add(translation);
      }
    }

    return translations;
  }

  Future<List<Translation>> retrieveAllTranslations() async {
    List<Translation> translations = [];
    DataSnapshot data = await dbRef.child("/Translation").get();

    for (var element in data.children) {
      TranslationDTO dataValue = TranslationDTO.fromJson(element.value as Map);
      translations.add(Translation(key: element.key, translationDTO: dataValue));
    }

    return translations;
  }
}

