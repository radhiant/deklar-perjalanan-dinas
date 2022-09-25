import 'package:flutter/material.dart';

class CustomTheme {
  static final Color occur = Color(0xffb38220);
  static final Color peach = Color(0xffe09c5f);
  static final Color skyBlue = Color(0xff639fdc);
  static final Color darkGreen = Color(0xff226e79);
  static final Color red = Color(0xfff8575e);
  static final Color purple = Color(0xff9f50bf);
  static final Color pink = Color(0xffd17b88);
  static final Color brown = Color(0xffbd631a);
  static final Color blue = Color(0xff1a71bd);
  static final Color green = Color(0xff068425);
  static final Color yellow = Color(0xfffff44f);
  static final Color orange = Color(0xffFFA500);

  final Color card,
      cardDark,
      border,
      borderDark,
      disabledColor,
      onDisabled,
      colorInfo,
      colorWarning,
      colorSuccess,
      colorError,
      shadowColor,
      onInfo,
      onWarning,
      onSuccess,
      onError,
      shimmerBaseColor,
      shimmerHighlightColor;

  final Color groceryPrimary, groceryOnPrimary;

  final Color medicarePrimary, medicareOnPrimary;

  final Color cookifyPrimary, cookifyOnPrimary;

  final Color lightBlack, violet, indigo;

  final Color estatePrimary,
      estateOnPrimary,
      estateSecondary,
      estateOnSecondary;
  final Color datingPrimary,
      datingOnPrimary,
      datingSecondary,
      datingOnSecondary;

  final Color homemadePrimary,
      homemadeSecondary,
      homemadeOnPrimary,
      homemadeOnSecondary;
  final Color muviPrimary, muviOnPrimary;

  @deprecated
  final Color learningPrimary,
      learningOnPrimary,
      learningCategory1,
      learningCategory2,
      learningCategory3,
      learningCategory4,
      learningCategory5;

  final Color fitnessPrimary,
      fitnessOnPrimary,
      magenta,
      oliveGreen,
      carolinaBlue;

  CustomTheme({
    this.border = const Color(0xffeeeeee),
    this.borderDark = const Color(0xffe6e6e6),
    this.card = const Color(0xfff0f0f0),
    this.cardDark = const Color(0xfffefefe),
    this.disabledColor = const Color(0xffdcc7ff),
    this.onDisabled = const Color(0xffffffff),
    this.colorWarning = const Color(0xffffc837),
    this.colorInfo = const Color(0xffff784b),
    this.colorSuccess = const Color(0xff3cd278),
    this.shadowColor = const Color(0xff1f1f1f),
    this.onInfo = const Color(0xffffffff),
    this.onWarning = const Color(0xffffffff),
    this.onSuccess = const Color(0xffffffff),
    this.colorError = const Color(0xfff0323c),
    this.onError = const Color(0xffffffff),
    this.shimmerBaseColor = const Color(0xFFF5F5F5),
    this.shimmerHighlightColor = const Color(0xFFE0E0E0),

    //Grocery color scheme
    this.groceryPrimary = const Color(0xff10bb6b),
    this.groceryOnPrimary = const Color(0xffffffff),

    //Cookify
    this.cookifyPrimary = const Color(0xffdf7463),
    this.cookifyOnPrimary = const Color(0xffffffff),

    //Color
    this.lightBlack = const Color(0xffa7a7a7),
    this.indigo = const Color(0xff4B0082),
    this.violet = const Color(0xff9400D3),

    //Medicare Color Scheme
    this.medicarePrimary = const Color(0xff6d65df),
    this.medicareOnPrimary = const Color(0xffffffff),

    //Estate Color Scheme
    this.estatePrimary = const Color(0xff1c8c8c),
    this.estateOnPrimary = const Color(0xffffffff),
    this.estateSecondary = const Color(0xfff15f5f),
    this.estateOnSecondary = const Color(0xffffffff),

    //Dating Color Scheme
    this.datingPrimary = const Color(0xffB428C3),
    this.datingOnPrimary = const Color(0xffffffff),
    this.datingSecondary = const Color(0xfff15f5f),
    this.datingOnSecondary = const Color(0xffffffff),

    //Homemade Color Scheme
    this.homemadePrimary = const Color(0xffc5558e),
    this.homemadeSecondary = const Color(0xffCC9D60),
    this.homemadeOnPrimary = const Color(0xffffffff),
    this.homemadeOnSecondary = const Color(0xffffffff),

    //Muvi Color Scheme
    this.muviPrimary = const Color(0xff4B97C5),
    this.muviOnPrimary = const Color(0xffffffff),

    //Learning Primary
    this.learningPrimary = const Color(0xff6874E8),
    this.learningOnPrimary = const Color(0xffFDF6ED),
    this.learningCategory1 = const Color(0xff46A4E4),
    this.learningCategory2 = const Color(0xffEC84B5),
    this.learningCategory3 = const Color(0xffD28638),
    this.learningCategory4 = const Color(0xff16a058),
    this.learningCategory5 = const Color(0xffe55d27),

    //Fitness Primary
    this.fitnessPrimary = const Color(0xff2D72F0),
    this.fitnessOnPrimary = const Color(0xffFAF9F9),
    this.magenta = const Color(0xff8B5587),
    this.oliveGreen = const Color(0xff4aa359),
    this.carolinaBlue = const Color(0xff069DEF),
  });

  //--------------------------------------  Custom App Theme ----------------------------------------//

  static final CustomTheme lightCustomTheme = CustomTheme(
      card: Color(0xfff6f6f6),
      cardDark: Color(0xfff0f0f0),
      disabledColor: Color(0xff636363),
      onDisabled: Color(0xffffffff),
      colorInfo: Color(0xffff784b),
      colorWarning: Color(0xffffc837),
      colorSuccess: Color(0xff3cd278),
      shadowColor: Color(0xffd9d9d9),
      onInfo: Color(0xffffffff),
      onSuccess: Color(0xffffffff),
      onWarning: Color(0xffffffff),
      colorError: Color(0xfff0323c),
      onError: Color(0xffffffff),
      shimmerBaseColor: Color(0xFFF5F5F5),
      shimmerHighlightColor: Color(0xFFE0E0E0));

  static final CustomTheme darkCustomTheme = CustomTheme(
      card: Color(0xff222327),
      cardDark: Color(0xff101010),
      border: Color(0xff303030),
      borderDark: Color(0xff363636),
      disabledColor: Color(0xffbababa),
      onDisabled: Color(0xff000000),
      colorInfo: Color(0xffff784b),
      colorWarning: Color(0xffffc837),
      colorSuccess: Color(0xff3cd278),
      shadowColor: Color(0xff202020),
      onInfo: Color(0xffffffff),
      onSuccess: Color(0xffffffff),
      onWarning: Color(0xffffffff),
      colorError: Color(0xfff0323c),
      onError: Color(0xffffffff),
      shimmerBaseColor: Color(0xFF1a1a1a),
      shimmerHighlightColor: Color(0xFF454545));
}
