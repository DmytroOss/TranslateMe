import 'package:flutter/material.dart';

import '../../util/constants.dart';

InputDecoration AppInputDecoration(
    String hintText, Widget? prefix, Widget? suffix) {
  return InputDecoration(
    hintText: hintText,
    prefixIcon: prefix,
    suffixIcon: suffix,
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: AppColors.dark)),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: AppColors.accentDark)),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: AppColors.accentDark)),
    contentPadding: const EdgeInsets.fromLTRB(10, 2, 10, 5),
    filled: true,
    fillColor: const Color(0xffffffff),
  );
}
