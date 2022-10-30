import 'package:flutter/material.dart';

enum LanguageType { english, nepali }

const String english = 'en';
const String nepali = 'np';

const String assetsPathLocalisation = 'assets/translations';
const Locale englishLocale = Locale('en', 'US');
const Locale nepaliLocale = Locale('np', 'NP');

extension LanguageTypeExtension on LanguageType {
  String getValue() {
    switch (this) {
      case LanguageType.english:
        return english;
      case LanguageType.nepali:
        return nepali;
    }
  }
}
