/*
* File : App Theme
* Version : 1.0.0
* */

// Copyright 2021 The FlutX Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// [FxTextStyle] - gives 13 different type of styles to the text on the basis of size
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_theme.dart';

enum FxTextType {
  h4,
  h5,
  h6,
  sh1,
  sh2,
  button,
  caption,
  overline,

  // Material Design 3
  d1,
  d2,
  d3,
  h1,
  h2,
  h3,
  t1,
  t2,
  t3,
  l1,
  l2,
  l3,
  b1,
  b2,
  b3
}

class FxTextStyle {
  static Function _fontFamily = GoogleFonts.ibmPlexSans;

  static Map<int, FontWeight> _defaultFontWeight = {
    100: FontWeight.w100,
    200: FontWeight.w200,
    300: FontWeight.w300,
    400: FontWeight.w300,
    500: FontWeight.w400,
    600: FontWeight.w500,
    700: FontWeight.w600,
    800: FontWeight.w700,
    900: FontWeight.w800,
  };

  static Map<FxTextType, double> _defaultTextSize = {
    FxTextType.h4: 36,
    FxTextType.h5: 25,
    FxTextType.h6: 21,
    FxTextType.sh1: 17,
    FxTextType.sh2: 15,
    FxTextType.button: 13,
    FxTextType.caption: 12,
    FxTextType.overline: 10,

    // Material Design 3

    FxTextType.d1: 57,
    FxTextType.d2: 45,
    FxTextType.d3: 36,

    FxTextType.h1: 32,
    FxTextType.h2: 28,
    FxTextType.h3: 26,

    FxTextType.t1: 22,
    FxTextType.t2: 16,
    FxTextType.t3: 14,

    FxTextType.l1: 14,
    FxTextType.l2: 12,
    FxTextType.l3: 11,

    FxTextType.b1: 16,
    FxTextType.b2: 14,
    FxTextType.b3: 12,
  };

  static Map<FxTextType, int> _defaultTextFontWeight = {
    // Material Design 2 (Old)
    FxTextType.h4: 500,
    FxTextType.h5: 500,
    FxTextType.h6: 500,
    FxTextType.sh1: 500,
    FxTextType.sh2: 500,
    FxTextType.button: 500,
    FxTextType.caption: 500,
    FxTextType.overline: 500,

    //Material Design 3

    FxTextType.d1: 500,
    FxTextType.d2: 500,
    FxTextType.d3: 500,

    FxTextType.h1: 500,
    FxTextType.h2: 500,
    FxTextType.h3: 500,

    FxTextType.t1: 500,
    FxTextType.t2: 500,
    FxTextType.t3: 500,

    FxTextType.l1: 600,
    FxTextType.l2: 600,
    FxTextType.l3: 600,

    FxTextType.b1: 500,
    FxTextType.b2: 500,
    FxTextType.b3: 500,
  };

  static Map<FxTextType, double> _defaultLetterSpacing = {
    FxTextType.h4: 0,
    FxTextType.h5: 0,
    FxTextType.h6: 0,
    FxTextType.sh1: 0.15,
    FxTextType.sh2: 0.15,
    FxTextType.button: 0.15,
    FxTextType.caption: 0.15,
    FxTextType.overline: 0.15,

    //Material Design 3
    FxTextType.d1: -0.25,
    FxTextType.d2: 0,
    FxTextType.d3: 0,

    FxTextType.h1: -0.2,
    FxTextType.h2: -0.15,
    FxTextType.h3: 0,

    FxTextType.t1: 0,
    FxTextType.t2: 0.1,
    FxTextType.t3: 0.1,

    FxTextType.l1: 0.1,
    FxTextType.l2: 0.5,
    FxTextType.l3: 0.5,

    FxTextType.b1: 0.5,
    FxTextType.b2: 0.25,
    FxTextType.b3: 0.4,
  };

  static TextStyle getStyle(
      {TextStyle? textStyle,
      int? fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double letterSpacing = 0.15,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    double? finalFontSize = fontSize != null ? fontSize : textStyle!.fontSize;

    Color? finalColor;
    if (color == null) {
      Color themeColor =
          FxAppTheme.getThemeFromThemeMode().colorScheme.onBackground;
      finalColor = xMuted
          ? themeColor.withAlpha(160)
          : (muted ? themeColor.withAlpha(200) : themeColor);
    } else {
      finalColor = xMuted
          ? color.withAlpha(160)
          : (muted ? color.withAlpha(200) : color);
    }

    return _fontFamily(
        fontSize: finalFontSize,
        fontWeight: _defaultFontWeight[fontWeight] ?? FontWeight.w400,
        letterSpacing: letterSpacing,
        color: finalColor,
        decoration: decoration,
        height: height,
        wordSpacing: wordSpacing);
  }

  static TextStyle h4(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[FxTextType.h4],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[FxTextType.h4] ?? 0,
        fontWeight: fontWeight,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle h5(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[FxTextType.h5],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[FxTextType.h5] ?? 0,
        fontWeight: fontWeight,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle h6(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[FxTextType.h6],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[FxTextType.h6] ?? 0,
        fontWeight: fontWeight,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle sh1(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[FxTextType.sh1],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[FxTextType.sh1] ?? 0.15,
        fontWeight: fontWeight,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle sh2(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[FxTextType.sh2],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[FxTextType.sh2] ?? 0.15,
        fontWeight: fontWeight,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle button(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[FxTextType.button],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[FxTextType.button] ?? 0.15,
        fontWeight: fontWeight,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle caption(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing = 0,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[FxTextType.caption],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[FxTextType.caption] ?? 0.15,
        fontWeight: fontWeight,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle overline(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[FxTextType.overline],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[FxTextType.overline] ?? 0.15,
        fontWeight: fontWeight,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  // Material Design 3
  static TextStyle d1(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[FxTextType.d1],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[FxTextType.d1] ?? -0.2,
        fontWeight: _defaultTextFontWeight[FxTextType.d1] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle d2(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[FxTextType.d2],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[FxTextType.d2] ?? -0.2,
        fontWeight: _defaultTextFontWeight[FxTextType.d2] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle d3(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[FxTextType.d3],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[FxTextType.d3] ?? -0.2,
        fontWeight: _defaultTextFontWeight[FxTextType.d3] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle h1(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[FxTextType.h1],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[FxTextType.h1] ?? -0.2,
        fontWeight: _defaultTextFontWeight[FxTextType.h1] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle h2(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[FxTextType.h2],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[FxTextType.h2] ?? -0.15,
        fontWeight: _defaultTextFontWeight[FxTextType.h2] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle h3(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[FxTextType.h3],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[FxTextType.h3] ?? -0.15,
        fontWeight: _defaultTextFontWeight[FxTextType.h3] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle t1(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[FxTextType.t1],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[FxTextType.t1] ?? -0.15,
        fontWeight: _defaultTextFontWeight[FxTextType.t1] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle t2(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[FxTextType.t2],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[FxTextType.t2] ?? -0.15,
        fontWeight: _defaultTextFontWeight[FxTextType.t2] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle t3(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[FxTextType.t3],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[FxTextType.t3] ?? -0.15,
        fontWeight: _defaultTextFontWeight[FxTextType.t3] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle l1(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[FxTextType.l1],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[FxTextType.l1] ?? -0.15,
        fontWeight: _defaultTextFontWeight[FxTextType.l1] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle l2(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[FxTextType.l2],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[FxTextType.l2] ?? -0.15,
        fontWeight: _defaultTextFontWeight[FxTextType.l2] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle l3(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[FxTextType.l3],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[FxTextType.l3] ?? -0.15,
        fontWeight: _defaultTextFontWeight[FxTextType.l3] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle b1(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[FxTextType.b1],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[FxTextType.b1] ?? 0.15,
        fontWeight: _defaultTextFontWeight[FxTextType.b1] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle b2(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[FxTextType.b2],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[FxTextType.b2] ?? 0.15,
        fontWeight: _defaultTextFontWeight[FxTextType.b2] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle b3(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[FxTextType.b3],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[FxTextType.b3] ?? 0.15,
        fontWeight: _defaultTextFontWeight[FxTextType.b3] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static void changeFontFamily(Function fontFamily) {
    FxTextStyle._fontFamily = fontFamily;
  }

  static void changeDefaultFontWeight(Map<int, FontWeight> defaultFontWeight) {
    FxTextStyle._defaultFontWeight = defaultFontWeight;
  }

  static void changeDefaultTextSize(Map<FxTextType, double> defaultTextSize) {
    FxTextStyle._defaultTextSize = defaultTextSize;
  }

  static Map<FxTextType, double> get defaultTextSize => _defaultTextSize;

  static Map<FxTextType, double> get defaultLetterSpacing =>
      _defaultLetterSpacing;

  static Map<FxTextType, int> get defaultTextFontWeight =>
      _defaultTextFontWeight;

  static Map<int, FontWeight> get defaultFontWeight => _defaultFontWeight;

  //-------------------Reset Font Styles---------------------------------
  static resetFontStyles() {
    _fontFamily = GoogleFonts.ibmPlexSans;

    _defaultFontWeight = {
      100: FontWeight.w100,
      200: FontWeight.w200,
      300: FontWeight.w300,
      400: FontWeight.w300,
      500: FontWeight.w400,
      600: FontWeight.w500,
      700: FontWeight.w600,
      800: FontWeight.w700,
      900: FontWeight.w800,
    };

    _defaultTextSize = {
      FxTextType.h4: 36,
      FxTextType.h5: 25,
      FxTextType.h6: 21,
      FxTextType.sh1: 17,
      FxTextType.sh2: 15,
      FxTextType.button: 13,
      FxTextType.caption: 12,
      FxTextType.overline: 10,

      // Material Design 3

      FxTextType.d1: 57,
      FxTextType.d2: 45,
      FxTextType.d3: 36,

      FxTextType.h1: 32,
      FxTextType.h2: 28,
      FxTextType.h3: 26,

      FxTextType.t1: 22,
      FxTextType.t2: 16,
      FxTextType.t3: 14,

      FxTextType.l1: 14,
      FxTextType.l2: 12,
      FxTextType.l3: 11,

      FxTextType.b1: 16,
      FxTextType.b2: 14,
      FxTextType.b3: 12,
    };

    _defaultTextFontWeight = {
      // Material Design 2 (Old)
      FxTextType.h4: 500,
      FxTextType.h5: 500,
      FxTextType.h6: 500,
      FxTextType.sh1: 500,
      FxTextType.sh2: 500,
      FxTextType.button: 500,
      FxTextType.caption: 500,
      FxTextType.overline: 500,

      //Material Design 3

      FxTextType.d1: 500,
      FxTextType.d2: 500,
      FxTextType.d3: 500,

      FxTextType.h1: 500,
      FxTextType.h2: 500,
      FxTextType.h3: 500,

      FxTextType.t1: 500,
      FxTextType.t2: 500,
      FxTextType.t3: 500,

      FxTextType.l1: 600,
      FxTextType.l2: 600,
      FxTextType.l3: 600,

      FxTextType.b1: 500,
      FxTextType.b2: 500,
      FxTextType.b3: 500,
    };

    _defaultLetterSpacing = {
      FxTextType.h4: 0,
      FxTextType.h5: 0,
      FxTextType.h6: 0,
      FxTextType.sh1: 0.15,
      FxTextType.sh2: 0.15,
      FxTextType.button: 0.15,
      FxTextType.caption: 0.15,
      FxTextType.overline: 0.15,

      //Material Design 3
      FxTextType.d1: -0.25,
      FxTextType.d2: 0,
      FxTextType.d3: 0,

      FxTextType.h1: -0.2,
      FxTextType.h2: -0.15,
      FxTextType.h3: 0,

      FxTextType.t1: 0,
      FxTextType.t2: 0.1,
      FxTextType.t3: 0.1,

      FxTextType.l1: 0.1,
      FxTextType.l2: 0.5,
      FxTextType.l3: 0.5,

      FxTextType.b1: 0.5,
      FxTextType.b2: 0.25,
      FxTextType.b3: 0.4,
    };
  }
}
