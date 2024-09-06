import 'package:flutter/cupertino.dart';

import '../../../models/saved_word.dart';
import '../../../widgets/containers/padded_container.dart';
import '../../../widgets/inner_text.dart';


class SavedWordInfo extends StatelessWidget {
  final SavedWord wordModel;

  const SavedWordInfo({super.key, required this.wordModel});

  @override
  Widget build(BuildContext context) {
    return PaddedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(),
          InnerText(text: wordModel.savedWordDTO!.explanation),
        ],
      ),
    );
  }
}
