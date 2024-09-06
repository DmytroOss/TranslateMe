import 'package:flutter/material.dart';
import 'package:translation_app/features/archieve/archieve_item.dart';
import 'package:translation_app/models/user.dart';
import 'package:translation_app/services/auth_service.dart';
import 'package:translation_app/services/translation_service.dart';
import 'package:translation_app/services/user_service.dart';

import '../../util/constants.dart';
import '../../widgets/appbar/appbar.dart';
import '../../widgets/containers/padded_container.dart';
import '../../widgets/inner_text.dart';
import '../saved_words/fragments/saved_word.dart';


class ArchievePage extends StatefulWidget{

  const ArchievePage({Key? key}) : super(key: key);

  @override
  State<ArchievePage> createState() => _ArchievePageState();

}


class _ArchievePageState extends State<ArchievePage> {

  late List translations = [

  ];

  @override
  initState(){
    retrieveUsersTranslations();
    super.initState();
  }

  Future<void> retrieveUsersTranslations() async {
    User user = await UserService().retrieveUserByEmail(AuthService().currentUser!.email!);
    translations = await TranslationService().retrieveTranslationByUser(user.key!);
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
                  itemCount: translations.length,
                  itemBuilder: (context, idx) {
                    return Column(
                        children: [

                        TranslationWidget(translation: translations[idx]),
                          Container(
                            width: 700,
                            decoration: const BoxDecoration(
                                border:
                                Border(bottom: BorderSide(color: AppColors.accent))),
                          ),
                        ]

                    ) ;
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
