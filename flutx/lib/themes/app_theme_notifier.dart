/*
* File : App Theme Notifier (Listener)
* Version : 1.0.0
* */

// Copyright 2021 The FlutX Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// [FxAppThemeNotifier] - notifies the app by giving the theme to the app

import 'dart:developer';

import 'package:flutter/material.dart';
// import 'custom_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_theme.dart';

class FxAppThemeNotifier extends ChangeNotifier {


  init() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    int fxAppThemeMode = sharedPreferences.getInt("fx_app_theme_mode")??FxAppThemeType.light.index;
    changeAppThemeMode(FxAppThemeType.values[fxAppThemeMode]);

    // int fxCustomThemeMode = sharedPreferences.getInt("fx_custom_theme_mode")??FxAppThemeType.light.index;
    // changeCustomThemeMode(FxCustomThemeType.values[fxCustomThemeMode]);

    notifyListeners();
  }

  changeAppThemeMode(FxAppThemeType? themeType) async {
    FxAppTheme.defaultThemeType = themeType!;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setInt("fx_app_theme_mode", themeType.index);

    log(FxAppTheme.getThemeFromThemeMode().toString());
    notifyListeners();

  }

  // changeCustomThemeMode(FxCustomThemeType? themeType) async {
  //   FxCustomTheme.defaultThemeType = themeType!;
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   await sharedPreferences.setInt("fx_custom_theme_mode", themeType.index);
  //
  //   notifyListeners();
  // }

}