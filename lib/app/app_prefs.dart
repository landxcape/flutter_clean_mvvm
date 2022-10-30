// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import '/presentation/resources/language_manager.dart';

const String prefsKeyLang = 'prefsKeyLang';
const String prefsKeyOnboardingScreen = 'prefsKeyOnboardingScreen';
const String prefsKeyIsUserLoggedIn = 'prefsKeyIsUserLoggedIn';
const String prefsKeyToken = 'prefsKeyToken';

class AppPreferences {
  final SharedPreferences _sharedPreferences;
  AppPreferences(this._sharedPreferences);

  Future<String> getAppLanguage() async {
    String? language = _sharedPreferences.getString(prefsKeyLang);

    return language ?? LanguageType.english.getValue();
  }

  Future<void> setLanguageChanged() async {
    String currentLanguage = await getAppLanguage();

    if (currentLanguage == LanguageType.nepali.getValue()) {
      // save prefs with english
      _sharedPreferences.setString(prefsKeyLang, LanguageType.english.getValue());
    } else {
      // save prefs with nepali
      _sharedPreferences.setString(prefsKeyLang, LanguageType.nepali.getValue());
    }
  }

  Future<Locale> getLocale() async {
    String currentLanguage = await getAppLanguage();

    if (currentLanguage == LanguageType.nepali.getValue()) {
      // return nepali local
      return nepaliLocale;
    } else {
      // return english local
      return englishLocale;
    }
  }

  Future<void> setOnboardingScreenViewed() async {
    _sharedPreferences.setBool(prefsKeyOnboardingScreen, true);
  }

  Future<bool> isOnboardingScreenViewed() async {
    return _sharedPreferences.getBool(prefsKeyOnboardingScreen) ?? false;
  }

  Future<void> setToken(String token) async {
    _sharedPreferences.setString(prefsKeyToken, token);
  }

  Future<String> getToken() async {
    return _sharedPreferences.getString(prefsKeyToken) ?? 'NO SAVED TOKEN';
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
