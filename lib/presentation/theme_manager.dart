import 'package:flutter/material.dart';
import 'package:flutter_clean_mvvm/presentation/color_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    // main colors of the app
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.primaryOpacity70,
    primaryColorDark: ColorManager.primaryDark,
    disabledColor: ColorManager.grey1, // for disable button
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: ColorManager.grey,
    ),

    // card view theme

    // app bar theme

    // button theme

    // text theme

    // input decorations theme (text form field)
  );
}