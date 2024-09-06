import 'package:flutter/material.dart';

import '../util/constants.dart';
import 'inner_text.dart';

class TranslateBanner extends StatelessWidget {
  final bool hasShadow;
  final bool isCentered;
  final bool isTransparent;
  final bool isVertical;

  const TranslateBanner(
      {super.key,
      this.hasShadow = true,
      this.isCentered = false,
      this.isVertical = false,
      this.isTransparent = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: isTransparent ? Colors.transparent : AppColors.accent,
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(40),
            bottomLeft: Radius.circular(40),
          ),
          boxShadow: [
            if (hasShadow)
              BoxShadow(
                color: AppColors.accentDark.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 1),
              ),
          ]),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(40),
          bottomLeft: Radius.circular(40),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
          child: Flex(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment:
                isCentered ? MainAxisAlignment.center : MainAxisAlignment.start,
            direction: isVertical ? Axis.vertical : Axis.horizontal,
            children: [
              SizedBox(
                width: 70,
                height: 76,
                child:
                    Image.asset('assets/page-1/images/logo.png'),
              ),
              const SizedBox(
                height: 14,
                width: 14,
              ),
              const InnerText(
                  text: "Translate me", fontSize: 42, fontWeight: FontWeight.w500)
            ],
          ),
        ),
      ),
    );
  }
}
