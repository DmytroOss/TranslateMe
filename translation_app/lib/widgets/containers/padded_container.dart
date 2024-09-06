import 'package:flutter/cupertino.dart';

class PaddedContainer extends StatelessWidget {
  final Widget child;
  final double padding;

  const PaddedContainer({super.key, required this.child, this.padding = 16});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: padding),
      child: child,
    );
  }
}
