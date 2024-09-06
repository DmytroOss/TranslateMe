import 'package:flutter/cupertino.dart';

enum FragmentRadius { full, large, normal, small }

extension FragmentRadiusValue on FragmentRadius {
  get radius {
    switch (this) {
      case FragmentRadius.full:
        return BorderRadius.circular(9999);
      case FragmentRadius.large:
        return BorderRadius.circular(20);
      case FragmentRadius.normal:
        return BorderRadius.circular(12);
      case FragmentRadius.small:
        return BorderRadius.circular(8);
    }
  }
}
