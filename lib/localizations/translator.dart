import 'dart:convert';

import 'package:flutter/services.dart';
import 'language.dart';

class Translator {
  static Map<String, String>? _localizedStrings;

  static Future<bool> changeLanguage(Language language) async {
    try {
      String jsonString = await rootBundle
          .loadString('assets/lang/${language.locale.languageCode}.json');
      Map<String, dynamic> jsonLanguageMap = json.decode(jsonString);
      _localizedStrings = jsonLanguageMap.map((key, value) {
        return MapEntry(key, value.toString());
      });
      return true;
    } catch (e) {}
    return false;
  }

  // called from every screens which needs a localized text
  static String translate(String text) {
    if (_localizedStrings != null) {
      String? value = _localizedStrings![text];
      return value == null ? autoTranslate(text) : value;
    }

    return text;
  }

  static String autoTranslate(String text) {
    // log("You need to translate this text : " + text);

    try {
      List<String> texts = text.split("_");
      StringBuffer stringBuffer = StringBuffer();
      for (String singleText in texts) {
        stringBuffer
            .write(singleText[0].toUpperCase() + singleText.substring(1) + " ");
      }
      return stringBuffer.toString();
    } catch (err) {
      return text;
    }
  }
}
