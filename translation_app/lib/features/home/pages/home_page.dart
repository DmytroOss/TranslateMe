import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:translation_app/features/info_popup.dart';
import 'package:translation_app/models/translation.dart';
import 'package:translation_app/services/auth_service.dart';
import 'package:translation_app/services/openai_service.dart';
import 'package:translation_app/services/translation_service.dart';
import 'package:translation_app/services/tts_service.dart';
import 'package:translation_app/util/constants.dart';
import 'package:translation_app/widgets/inner_text.dart';

import '../../../models/user.dart';
import '../../../services/user_service.dart';
import '../../../widgets/appbar/appbar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<String> _languages = [
    'English',
    'Ukrainian',
    'French',
    'German',
    'Spanish',
    'Polish',
    'Croatian',
    'Bulgarian',
    'Danish',
    'Estonian',
    'Italian',
    'Greek',
    'Hungarian',
    'Slovak',
    'Swedish',
   'Portuguese',
    'Romanian',
    'Crimean Tatar',
  ];
  final ttsService = TtsService();
  String _selectedFromLanguage = 'English';
  String _selectedToLanguage = 'Ukrainian';
  final OpenAiService openAiService = OpenAiService();

  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _outputController = TextEditingController();

  final SpeechToText _speechToText = SpeechToText();

  bool _speechEnabled = false;
  bool textVoice = false;

  @override
  void initState(){
    super.initState();
    _initSpeech();
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  void onSpeechResult(result) {
    setState(() {
      _inputController.text = result.recognizedWords;
    });
  }
  void _stopListening() {
    _speechToText.stop();
    setState(() {});
  }



  Widget _buildLanguageDropdown(
      BuildContext context,
      String labelText,
      String selectedValue,
      ValueChanged<String?> onChanged,
      ) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.black),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.grey),
        ),
      ),
      value: selectedValue,
      items: _languages.map((language) => DropdownMenuItem(
        value: language,
        child: Text(language),
      )).toList(),
      onChanged: onChanged,
    );
  }


  Future<String> retrieveWordsExplanation(String word) async{

    var prompt = """
    надай пояснення до слова мовою якою воно написане: $word
    """;

    final explanation = await openAiService.getResponse(prompt);

    if(explanation == null){
      throw Exception('Помилка пд час отриманн пояснення');
    }

    return explanation;

  }

  Future<List<String>> retrieveSynonimusText(String text) async {
    var prompt = """
    надай синоніми цього слова перераховані через знак ",", не додаючи більше ніякого тексту та пояснень:
    $text
  """;

    final translatedText = await openAiService.getResponse(prompt);

    if (translatedText == null) {
      throw Exception('Помилка під час перекладу тексту.');
    }

    var result = translatedText.split(',');

    return result;
  }

  Future<String?> translateText(String fromLanguage, String toLanguage, String text) async {
    var prompt = """
    Переклади наступний текст з $fromLanguage на $toLanguage, відповіддю надай тільки переклад, без додаткових пояснень:

    $text
  """;

    final translatedText = await openAiService.getResponse(prompt);

    if (translatedText == null) {
      throw Exception('Помилка під час перекладу тексту.');
    }

    setState(() {
      _outputController.text = translatedText;
    });

    User user =  await UserService().retrieveUserByEmail(AuthService().currentUser!.email!);

    await TranslationService().createTranslation(
        translation: TranslationDTO(
            translationText: text,
            translatedText: translatedText,
            translationLanguage: fromLanguage,
            translatedToLanguage: toLanguage,
            userKey: user.key!,
        )
    );
    return translatedText;
  }


  Future<String?> reTranslateText(String fromLanguage, String toLanguage, String text) async {

    var synonym = await getSelectedSynonym();

    var prompt = """
    Переклади наступний текст з $fromLanguage на $toLanguage, відповіддю надай тільки переклад, без додаткових пояснень та використай залежно від контексту слово $synonym:

    $text
  """;

    final translatedText = await openAiService.getResponse(prompt);

    if (translatedText == null) {
      throw Exception('Помилка під час перекладу тексту.');
    }

    setState(() {
      _outputController.text = translatedText;
    });

    User user =  await UserService().retrieveUserByEmail(AuthService().currentUser!.email!);

    await TranslationService().createTranslation(
        translation: TranslationDTO(
          translationText: text,
          translatedText: translatedText,
          translationLanguage: fromLanguage,
          translatedToLanguage: toLanguage,
          userKey: user.key!,
        )
    );
    return translatedText;
  }

  Future<String> getSelectedSynonym() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('syn')!;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: Appbar.createBannerAppBar(),/*AppBar(
        title: const InnerText(text: 'TranslateMe'),
        backgroundColor: const Color(0xFF0079D7),
      ),*/
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: _buildLanguageDropdown(
                    context,
                    'З мови',
                    _selectedFromLanguage,
                        (value) => setState(() => _selectedFromLanguage = value!),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: _buildLanguageDropdown(
                    context,
                    'На мову',
                    _selectedToLanguage,
                        (value) => setState(() => _selectedToLanguage = value!),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: Column(
                children: [
                  InputTextField(
                    hintText: 'введіть текст',
                    backgroundColor: const Color(0xFFF5F5F5),
                    controller: _inputController,
                    myOnTap: null,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        alignment: Alignment.topRight,
                        onPressed: (){
                          _speechToText.isListening
                              ? _stopListening()
                              : _startListening();
                        },
                        icon: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
                      ),
                      IconButton(
                          alignment: Alignment.topRight,
                          onPressed: (){
                            ttsService.speak(_inputController.text);
                          },
                          icon: const Icon(Icons.volume_up_rounded)),
                    ],
                  ),
                  TranslatedTextField(
                    hintText: 'переклад',
                    readOnly: true,
                    backgroundColor: const Color(0xFFF5F5F5),
                    controller: _outputController,
                    translation: _outputController.text,
                    onWordTap: (String word) async{
                      var syn = await retrieveSynonimusText(word);
                      var explanation = await retrieveWordsExplanation(word);
                      InfoPopup(
                        word: word,
                      synonyms: syn,
                      explanation: explanation,
                      ).show(context);
                      Future.delayed(const Duration(seconds: 2)).then((value) =>
                      reTranslateText(_selectedFromLanguage, _selectedToLanguage, _inputController.text)
                      );
                    },
                  ),
                  IconButton(
                    alignment: Alignment.topRight,
                      onPressed: (){
                        ttsService.speak(_outputController.text);
                        },
                      icon: const Icon(Icons.volume_up_rounded))
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if(_selectedFromLanguage.isNotEmpty && _selectedToLanguage.isNotEmpty && _inputController.text.isNotEmpty){
                  translateText(_selectedFromLanguage, _selectedToLanguage, _inputController.text);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent
              ),
              child: const InnerText(text: 'translate'),
            ),
          ],
        ),
      ),
    );
  }
}


class InputTextField extends StatelessWidget {
  const InputTextField({
    Key? key,
    this.hintText,
    this.readOnly = false,
    this.backgroundColor,
    required this.controller,
    required this.myOnTap
  }) : super(key: key);
  final String? hintText;
  final TextEditingController? controller;
  final bool readOnly;
  final Color? backgroundColor;
  final void Function()? myOnTap;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: AppColors.gray),
        filled: true,
        fillColor: backgroundColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: AppColors.gray),
        ),
      ),
      readOnly: readOnly,
      maxLines: null,
      controller: controller,
      minLines: 2,
      style: const TextStyle(fontSize: 16.0),
      onTap: myOnTap,
    );
  }
}


class TranslatedTextField extends StatelessWidget {
  const TranslatedTextField({
    Key? key,
    this.hintText,
    this.readOnly = false,
    this.backgroundColor,
    required this.controller,
    required this.translation,
    required this.onWordTap,
  }) : super(key: key);

  final String? hintText;
  final TextEditingController? controller;
  final bool readOnly;
  final Color? backgroundColor;
  final String translation;
  final void Function(String word)? onWordTap;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: AppColors.gray), // Assuming AppColors.gray is similar to Colors.grey
        filled: true,
        fillColor: backgroundColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: AppColors.gray), // Assuming AppColors.gray is similar to Colors.grey
        ),
      ),
      readOnly: readOnly,
      maxLines: null,
      controller: controller,
      minLines: 2,
      style: const TextStyle(fontSize: 16.0),
      onTap: () {
        if (onWordTap != null) {
          final words = translation.split(' ');
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const InnerText(
                    text: 'Translated Text',
                    fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: words.map((word) {
                    return InkWell(
                      onTap: () {
                        onWordTap!(word);
                        Navigator.of(context).pop();
                      },
                      child: InnerText(
                        text: word,
                        fontSize: 20,
                      ),
                    );
                  }).toList(),
                ),
              );
            },
          );
        }
      },
    );
  }
}










