import 'package:firebase_database/firebase_database.dart';

import '../../models/saved_word.dart';

class SavedWordService {
  DatabaseReference dbRef = FirebaseDatabase.instance.ref();

  createSavedWord({required SavedWordDTO savedWord}) async {
    var obj = dbRef.child('/SavedWord').push();
    await obj.set(savedWord.toJson());
    return obj;
  }

  SavedWord retrieveSavedWordByKey(String key){
    List<SavedWord> sv = retrieveAllSavedWords() as List<SavedWord>;
    SavedWord res = sv[0];
    for(var el in sv){
      if(el.savedWordDTO!.userKey == key){
        res = el;
      }
    }
    return res;
  }

  Future<List<SavedWord>> retrieveSavedWordsByUser(String userKey) async {
    List<SavedWord> savedWords = [];
    DataSnapshot data = await dbRef.child("/SavedWord").get();
    for (var element in data.children) {
      SavedWordDTO dataValue = SavedWordDTO.fromJson(element.value as Map);
      SavedWord translation = SavedWord(key: element.key, savedWordDTO: dataValue);
      if (translation.savedWordDTO!.userKey == userKey) {
        savedWords.add(translation);
      }
    }

    return savedWords;
  }

  Future<List<SavedWord>> retrieveAllSavedWords() async {
    List<SavedWord> savedWords = [];
    DataSnapshot data = await dbRef.child("/SavedWord").get();

    for (var element in data.children) {
      SavedWordDTO dataValue = SavedWordDTO.fromJson(element.value as Map);
      savedWords.add(SavedWord(key: data.key, savedWordDTO: dataValue));
    }

    return savedWords;
  }
}
