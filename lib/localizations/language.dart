import 'package:flutter/material.dart';
import 'package:deklarasi/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'translator.dart';

class Language {
  final Locale locale;
  final bool supportRTL;
  final String languageName;

  static List<Language> languages = [
    Language(Locale('en'), "English"),
    Language(Locale('hi'), "Hindi"),
    Language(
      Locale('ar'),
      "Arabic",
      true,
    ),
    Language(Locale('fr'), "French"),
    Language(Locale('zh'), "Chinese"),
    Language(Locale('id'), "Indonesian"),
  ];

  static Language currentLanguage = languages.first;

  Language(this.locale, this.languageName, [this.supportRTL = false]);

  static Future<bool> init() async {
    currentLanguage = await getLanguage();
    return true;
  }

  static List<Locale> getLocales() {
    return languages.map((e) => e.locale).toList();
  }

  static List<String> getLanguagesCodes() {
    return languages.map((e) => e.locale.languageCode).toList();
  }

  static Future<bool> changeLanguage(Language language) async {
    currentLanguage = language;
    await Translator.changeLanguage(language);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("lang_code", language.locale.languageCode);
    return true;
  }

  static Future<bool> changeLanguageByCode(String code) async {
    return await changeLanguage(getLanguageFromCode(code));
  }

  static Future<Language> getLanguage() async {
    Language? language;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? langCode = sharedPreferences.getString("lang_code");
    if (langCode != null) {
      language = findFromLocale(Locale(langCode));
    }

    return language ?? languages.first;
  }

  static Language getLanguageFromCode(String code) {
    Language language = languages.first;
    languages.forEach((element) {
      if (element.locale.languageCode == code) language = element;
    });
    return language;
  }

  static Language? findFromLocale(Locale locale) {
    for (Language language in languages) {
      if (language.locale.languageCode == locale.languageCode) return language;
    }
  }

  static T? autoDirection<T>([T? ltrValue, T? rtlValue]) {
    return AppTheme.textDirection == TextDirection.ltr ? ltrValue : rtlValue;
  }

  @override
  String toString() {
    return 'Language{locale: $locale, isRTL: $supportRTL, languageName: $languageName}';
  }
}
