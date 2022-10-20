enum LanguageType { english, nepali }

const String english = 'en';
const String nepali = 'np';

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
