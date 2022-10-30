// Package imports:
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import '/presentation/resources/language_manager.dart';

const String prefsKeyLang = 'prefsKeyLang';
const String prefsKeyOnboardingScreen = 'prefsKeyOnboardingScreen';
const String prefsKeyIsUserLoggedIn = 'prefsKeyIsUserLoggedIn';

class AppPreferences {
  final SharedPreferences _sharedPreferences;
  AppPreferences(this._sharedPreferences);

  Future<String> getAppLanguage() async {
    String? language = _sharedPreferences.getString(prefsKeyLang);

    return language ?? LanguageType.english.getValue();
  }

  Future<void> setOnboardingScreenViewed() async {
    _sharedPreferences.setBool(prefsKeyOnboardingScreen, true);
  }

  Future<bool> isOnboardingScreenViewed() async {
    return _sharedPreferences.getBool(prefsKeyOnboardingScreen) ?? false;
  }

  Future<void> setIsUserLoggedIn() async {
    _sharedPreferences.setBool(prefsKeyIsUserLoggedIn, true);
  }

  Future<bool> isUserLoggedIn() async {
    return _sharedPreferences.getBool(prefsKeyIsUserLoggedIn) ?? false;
  }

  Future<void> logout() async {
    _sharedPreferences.remove(prefsKeyIsUserLoggedIn);
  }
}
