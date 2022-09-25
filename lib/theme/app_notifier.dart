/*
* File : App Theme Notifier (Listener)
* Version : 1.0.0
* */

import 'package:deklarasi/localizations/language.dart';
import 'package:deklarasi/theme/app_theme.dart';
import 'package:deklarasi/theme/material_theme.dart';
import 'package:deklarasi/theme/theme_type.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:deklarasi/extensions/theme_extension.dart';

class AppNotifier extends ChangeNotifier {
  AppNotifier() {
    init();
  }

  init() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    ThemeType themeType =
        sharedPreferences.getString("theme_mode").toString().toThemeType;
    _changeTheme(themeType);
    notifyListeners();
  }

  updateTheme(ThemeType themeType) {
    _changeTheme(themeType);

    notifyListeners();

    updateInStorage(themeType);
  }

  Future<void> updateInStorage(ThemeType themeType) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("theme_mode", themeType.toText);
  }

  void changeDirectionality(TextDirection textDirection, [bool notify = true]) {
    AppTheme.textDirection = textDirection;
    FxAppTheme.textDirection = textDirection;

    if (notify) notifyListeners();
  }

  Future<void> changeLanguage(Language language,
      [bool notify = true, bool changeDirection = true]) async {
    if (changeDirection) {
      if (language.supportRTL)
        changeDirectionality(TextDirection.rtl, false);
      else
        changeDirectionality(TextDirection.ltr, false);
    }

    await Language.changeLanguage(language);

    if (notify) notifyListeners();
  }

  void _changeTheme(ThemeType themeType) {
    AppTheme.themeType = themeType;
    AppTheme.customTheme = AppTheme.getCustomTheme(themeType);
    AppTheme.theme = AppTheme.getTheme(themeType);
    MaterialTheme.resetThemeData();
    AppTheme.changeFxTheme(themeType);
  }
}
