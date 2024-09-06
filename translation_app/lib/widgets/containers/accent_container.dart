import 'package:flutter/cupertino.dart';

import '../../util/constants.dart';
import '../enums/fragment_radius.dart';


class AccentContainer extends StatelessWidget {
  final Widget child;
  final double borderWidth;
  final FragmentRadius radius;
  final double? height;

  const AccentContainer(
      {super.key,
      required this.child,
      this.borderWidth = 0,
      this.radius = FragmentRadius.large,
      this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
          color: AppColors.accent,
          border: Border.all(color: AppColors.accentDark, width: borderWidth),
          borderRadius: radius.radius),
      child: child,
    );
  }
}
