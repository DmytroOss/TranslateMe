import 'package:flutter/cupertino.dart';

import '../../../models/saved_word.dart';
import '../../../widgets/appbar/appbar_title.dart';
import '../../../widgets/inner_text.dart';
import '../../../widgets/popups/bottom_popup.dart';
import '../popups/saved_word_info.dart';

class SavedWordWidget extends StatelessWidget {
  final SavedWord wordModel;

  const SavedWordWidget({super.key, required this.wordModel});
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 23),
      child: GestureDetector(
        onTap: () {
          BottomPopup.showPopup(
              context,
              AppbarTitle(text: wordModel.savedWordDTO!.translation),
              SavedWordInfo(
                wordModel: wordModel,
              ));
        },
        child: InnerText(
          text: wordModel.savedWordDTO!.translation,
          fontSize: 20,
        ),
      ),
    );
  }
}
