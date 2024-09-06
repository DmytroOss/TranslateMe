import 'dart:ffi';

import 'package:flutter/material.dart';

import '../../../services/openai_service.dart';
import '../../../util/constants.dart';
import '../../../widgets/enums/fragment_radius.dart';
import '../../../widgets/inner_text.dart';

class FieldItem extends StatefulWidget {
  final String text;
  final bool isSentByMe;
  final OpenAiService openAiService = OpenAiService();

  FieldItem(
      {required super.key, required this.text, required this.isSentByMe});

  @override
  State<FieldItem> createState() => _FieldItemState();
}

class _FieldItemState extends State<FieldItem> {

  String _translation = "";
  bool _showTranslation = false;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final Color accent = widget.isSentByMe
        ? AppColors.accentDark.withOpacity(0.7)
        : AppColors.accentDark;

    return Align(
      alignment:
          Alignment.center,
      child: Container(
        width: double.infinity,
        height: 300,
        margin: const EdgeInsets.symmetric(vertical:20, horizontal: 0),
        padding: const EdgeInsets.all(24.0),
        constraints: const BoxConstraints(maxWidth: 570),
        decoration: BoxDecoration(
          color: widget.isSentByMe ? AppColors.light : AppColors.accent,
          boxShadow: [
            BoxShadow(
                spreadRadius: 0,
                blurRadius: 4,
                color: AppColors.gray.withOpacity(0.5)),
          ],
          borderRadius: FragmentRadius.large.radius,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 14),
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: accent, width: 0))),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                textDirection:
                    widget.isSentByMe ? TextDirection.ltr : TextDirection.rtl,
                children: [
                  Flexible(
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 580),
                      child: InnerText(
                        text: _showTranslation ? _translation : widget.text,
                        fontSize: 18,
                        color:
                            !_loading ? AppColors.dark : AppColors.accentDark,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    onPressed: () async {
                      setState(() {
                        _loading = true;
                      });

                      await translate();

                      setState(() {
                        _loading = false;
                        _showTranslation = !_showTranslation;
                      });
                    },
                    icon: _showTranslation
                        ? Icon(
                            Icons.cancel_outlined,
                            color: accent,
                          )
                        : Icon(
                            Icons.translate_rounded,
                            color: accent,
                          )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> translate() async {
    if (_translation.isNotEmpty) {
      return;
    }

    String? aiResponse;

    try {
      aiResponse = await widget.openAiService
          .getResponse(
              "${widget.text}. If the above text is in English translate it to Ukrainian. "
              "In any other case translate it to English. "
              "Return only the translation")
          .timeout(const Duration(seconds: 5));
    } catch (e) {
      aiResponse = null;
    }

    if (aiResponse == null || aiResponse.isEmpty) {
      setState(() {
        _translation = "";
      });
      return;
    }

    setState(() {
      _translation = aiResponse.toString();
    });
  }
}
