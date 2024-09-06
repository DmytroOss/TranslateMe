import 'package:flutter/material.dart';
import 'package:translation_app/services/saved_word_service.dart';

import '../../../models/user.dart';
import '../../../services/auth_service.dart';
import '../../../services/user_service.dart';
import '../../../util/constants.dart';
import '../../../widgets/appbar/appbar.dart';
import '../../../widgets/containers/padded_container.dart';
import '../../../widgets/inner_text.dart';
import '../fragments/saved_word.dart';



class SavedWordPage extends StatefulWidget{

  const SavedWordPage({Key? key}): super(key:key);

  @override
  State<SavedWordPage> createState() => _SavedWordsPageState();

}


class _SavedWordsPageState extends State<SavedWordPage> {

  late List savedWords = [

  ];

  @override
  initState(){
    retrieveUsersSaves();
    super.initState();
  }

  Future<void> retrieveUsersSaves() async {
    User user = await UserService().retrieveUserByEmail(AuthService().currentUser!.email!);
    savedWords = await SavedWordService().retrieveSavedWordsByUser(user.key!);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar.createBannerAppBar(),
      body: PaddedContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: savedWords.length,
                  itemBuilder: (context, idx) {
                    return Column(
                      children: [
                        SavedWordWidget(wordModel: savedWords[idx]),
                        Container(
                          width: 700,
                          decoration: const BoxDecoration(
                              border:
                              Border(bottom: BorderSide(color: AppColors.accent))),
                        ),
                      ],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
