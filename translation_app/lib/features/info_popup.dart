import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translation_app/models/saved_word.dart';
import 'package:translation_app/services/auth_service.dart';
import 'package:translation_app/services/user_service.dart';
import 'package:translation_app/services/saved_word_service.dart';

import '../../../../widgets/button.dart';
import '../../../../widgets/enums/fragment_size.dart';
import '../../../../widgets/inner_text.dart';
import '../../../../widgets/popups/dialog_popup.dart';
import '../models/user.dart';

class InfoPopup {

  final String word;
  List<String> synonyms;
  final String explanation;

  InfoPopup({
    required this.word,
    required this.synonyms,
    required this.explanation,
  });

  addTranslationToSaved() async {
    User user = await UserService().retrieveUserByEmail(AuthService().currentUser!.email!);
    SavedWordService().createSavedWord(
        savedWord: SavedWordDTO(
            translation: word,
            userKey: user.key!,
            explanation: explanation,
        )
    );
  }

  Future<void> _saveWordToStorage(String wrd) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String wordKey = 'word';
    String synKey = 'syn';
    await prefs.setString(wordKey, word);
    await prefs.setString(synKey, wrd);
  }


  void show(BuildContext context) async {
    return DialogPopup.showPopup(
        context,
        SizedBox(
          width: 70,
          height: 2,
          child: Image.asset('assets/page-1/images/logo.png'),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            InnerText(
                text: "синоніми слова $word",
                fontSize: 30,
                fontWeight: FontWeight.bold,
            ),
            SizedBox(
              height: 30,
            ),
            InnerText(
              text: explanation,
              fontSize: 16,
            ),
          const SizedBox(
            height: 40,
          ),
          Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: synonyms.map((synonym) {
            return InkWell(
              onTap: () async{
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: InnerText(
                        text: 'Tapped synonym: $synonym',
                        fontSize: 22,
                    ),
                  ),
                );
                await _saveWordToStorage(synonym);
                Navigator.of(context).pop();
              },
              child: InnerText(
                text: synonym.trim(),
                fontSize: 24,
              ),
          );
        }).toList(),
      ),
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
          Button(
              size: FragmentSize.small,
              child: const InnerText(
                text: "Додати в збережені",
              ),
              onPressed: () {
                addTranslationToSaved();
                Navigator.pop(context);
              }),
        ]
    );
  }
}
