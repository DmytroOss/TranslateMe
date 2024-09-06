import 'package:flutter/material.dart';


import '../inner_text.dart';
import 'app_input_decoration.dart';

class DropdownInput extends StatelessWidget {
  final String label;
  final String hintText;

  final List<DropdownMenuItem> items;
  final void Function(dynamic) onChanged;

  const DropdownInput(
      {super.key,
      required this.label,
      required this.hintText,
      required this.items,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(left: 12, bottom: 6),
            child: InnerText(
              text: label,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        DropdownButtonFormField(
          items: items,
          icon: Image.asset(
            'assets/page-1/images/icon-chevron-down-arrow-icon-M6f.png',
            width: 15,
            height: 5,
          ),
          onChanged: onChanged,
          decoration: AppInputDecoration(
            hintText,
            null,
            null,
          ),
        ),
      ],
    );
  }
}
