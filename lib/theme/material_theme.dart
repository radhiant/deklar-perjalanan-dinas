import 'dart:developer';
import 'dart:ui';

import 'package:deklarasi/theme/app_theme.dart';
import 'package:deklarasi/theme/theme_type.dart';

class MaterialTheme {
  static MaterialThemeData materialThemeData =
      AppTheme.themeType == ThemeType.light
          ? MaterialThemeData().light()
          : MaterialThemeData().dark();

  static MaterialThemeData learningLightTheme = MaterialThemeData()
      .light()
      .copyWith(
          primary: Color(0xff6874E8),
          onPrimary: Color(0xffffffff),
          primaryContainer: Color(0xffe9eafd),
          onPrimaryContainer: Color(0xff2033e7),
          secondary: Color(0xff548c2f),
          onSecondary: Color(0xffffffff),
          secondaryContainer: Color(0xffdef0d1),
          onSecondaryContainer: Color(0xff131F0a));

  static MaterialThemeData learningDarkTheme = MaterialThemeData()
      .dark()
      .copyWith(
          primary: Color(0xffcfd2ff),
          onPrimary: Color(0xff1529e8),
          primaryContainer: Color(0xff5563e8),
          onPrimaryContainer: Color(0xffe6e7fd),
          secondary: Color(0xffd3ebc1),
          onSecondary: Color(0xff253e14),
          secondaryContainer: Color(0xff4B7b28),
          onSecondaryContainer: Color(0xffe9f5e0));

  static MaterialThemeData learningTheme = AppTheme.themeType == ThemeType.light
      ? learningLightTheme
      : learningDarkTheme;

  static MaterialThemeData cookifyLightTheme = MaterialThemeData()
      .light()
      .copyWith(
          primary: Color(0xffdf7463),
          onPrimary: Color(0xffffffff),
          primaryContainer: Color(0xfffdeeea),
          onPrimaryContainer: Color(0xffe73a1f),
          secondary: Color(0xff5e3f22),
          onSecondary: Color(0xffffffff),
          secondaryContainer: Color(0xffe7bc91),
          onSecondaryContainer: Color(0xff462601));

  static MaterialThemeData cookifyDarkTheme =
      MaterialThemeData().dark().copyWith(
            primary: Color(0xfffcccc5),
            onPrimary: Color(0xffec371a),
            primaryContainer: Color(0xffec6d5a),
            onPrimaryContainer: Color(0xffffeeec),
            secondary: Color(0xfffcc18e),
            onSecondary: Color(0xff381f01),
            secondaryContainer: Color(0xff54381e),
            onSecondaryContainer: Color(0xffe7cbae),
          );

  static MaterialThemeData cookifyTheme = AppTheme.themeType == ThemeType.light
      ? cookifyLightTheme
      : cookifyDarkTheme;

  static MaterialThemeData datingLightTheme = MaterialThemeData()
      .light()
      .copyWith(
          primary: Color(0xffB428C3),
          onPrimary: Color(0xffffffff),
          primaryContainer: Color(0xfffadcfd),
          onPrimaryContainer: Color(0xff770983),
          secondary: Color(0xfff15f5f),
          onSecondary: Color(0xffffffff),
          secondaryContainer: Color(0xfffcd8d8),
          onSecondaryContainer: Color(0xffea2929));

  static MaterialThemeData datingDarkTheme =
      MaterialThemeData().dark().copyWith(
            primary: Color(0xfff1b0f8),
            onPrimary: Color(0xff9614a4),
            primaryContainer: Color(0xffde4cef),
            onPrimaryContainer: Color(0xfff8d8fd),
            secondary: Color(0xfff88686),
            onSecondary: Color(0xff8f1313),
            secondaryContainer: Color(0xffec3535),
            onSecondaryContainer: Color(0xfff6cdcd),
          );

  static MaterialThemeData datingTheme = AppTheme.themeType == ThemeType.light
      ? datingLightTheme
      : datingDarkTheme;

  static MaterialThemeData estateLightTheme = MaterialThemeData()
      .light()
      .copyWith(
          primary: Color(0xff1c8c8c),
          onPrimary: Color(0xffffffff),
          primaryContainer: Color(0xffdafafa),
          onPrimaryContainer: Color(0xff025e5e),
          secondary: Color(0xfff15f5f),
          onSecondary: Color(0xffffffff),
          secondaryContainer: Color(0xfff8d6d6),
          onSecondaryContainer: Color(0xff570202));

  static MaterialThemeData estateDarkTheme = MaterialThemeData()
      .dark()
      .copyWith(
          primary: Color(0xffcaffff),
          onPrimary: Color(0xff0b7777),
          primaryContainer: Color(0xff18a6a6),
          onPrimaryContainer: Color(0xffe5fdfd),
          secondary: Color(0xffeea6a6),
          onSecondary: Color(0xff491818),
          secondaryContainer: Color(0xff7a2f2f),
          onSecondaryContainer: Color(0xffefdada));

  static MaterialThemeData estateTheme = AppTheme.themeType == ThemeType.light
      ? estateLightTheme
      : estateDarkTheme;

  static MaterialThemeData homemadeLightTheme = MaterialThemeData()
      .light()
      .copyWith(
          primary: Color(0xffc5558e),
          onPrimary: Color(0xffffffff),
          primaryContainer: Color(0xfffad2e6),
          onPrimaryContainer: Color(0xffc21f73),
          secondary: Color(0xffCC9D60),
          onSecondary: Color(0xffffffff),
          secondaryContainer: Color(0xfffce7cf),
          onSecondaryContainer: Color(0xffc47712));

  static MaterialThemeData homemadeDarkTheme = MaterialThemeData()
      .dark()
      .copyWith(
          primary: Color(0xfffaafd4),
          onPrimary: Color(0xffbb2e75),
          primaryContainer: Color(0xffd95a9b),
          onPrimaryContainer: Color(0xfffadaea),
          secondary: Color(0xffecc797),
          onSecondary: Color(0xff4f3616),
          secondaryContainer: Color(0xff855b25),
          onSecondaryContainer: Color(0xfff5e6d6));

  static MaterialThemeData homemadeTheme = AppTheme.themeType == ThemeType.light
      ? homemadeLightTheme
      : homemadeDarkTheme;

  static resetThemeData() {
    materialThemeData = AppTheme.themeType == ThemeType.light
        ? MaterialThemeData().light()
        : MaterialThemeData().dark();

    learningTheme = AppTheme.themeType == ThemeType.light
        ? learningLightTheme
        : learningDarkTheme;

    cookifyTheme = AppTheme.themeType == ThemeType.light
        ? cookifyLightTheme
        : cookifyDarkTheme;

    estateTheme = AppTheme.themeType == ThemeType.light
        ? estateLightTheme
        : estateDarkTheme;

    homemadeTheme = AppTheme.themeType == ThemeType.light
        ? homemadeLightTheme
        : homemadeDarkTheme;

    datingTheme = AppTheme.themeType == ThemeType.light
        ? datingLightTheme
        : datingDarkTheme;
  }
}

class MaterialThemeData {
  late Color primary,
      onPrimary,
      primaryContainer,
      onPrimaryContainer,
      secondary,
      onSecondary,
      secondaryContainer,
      onSecondaryContainer,
      tertiary,
      onTertiary,
      tertiaryContainer,
      onTertiaryContainer,
      error,
      onError,
      errorContainer,
      onErrorContainer,
      background,
      onBackground,
      surface,
      onSurface,
      surfaceVariant,
      onSurfaceVariant,
      outline,
      shimmerBaseColor,
      shimmerHighlightColor,
      card,
      onCard;

  late MaterialRadius containerRadius, buttonRadius, textFieldRadius;

  MaterialThemeData(
      {this.primary = const Color(0xff6750A4),
      this.onPrimary = const Color(0xffffffff),
      this.primaryContainer = const Color(0xffe8def8),
      this.onPrimaryContainer = const Color(0xff21025E),
      this.secondary = const Color(0xff625b71),
      this.onSecondary = const Color(0xffffffff),
      this.secondaryContainer = const Color(0xffe8def8),
      this.onSecondaryContainer = const Color(0xff000000),
      this.tertiary = const Color(0xff7d5260),
      this.onTertiary = const Color(0xffffffff),
      this.tertiaryContainer = const Color(0xfffbd8e4),
      this.onTertiaryContainer = const Color(0xff370b1e),
      this.error = const Color(0xffb3261e),
      this.onError = const Color(0xffffffff),
      this.errorContainer = const Color(0xfff9dedd),
      this.onErrorContainer = const Color(0xff370b1e),
      this.background = const Color(0xffffffff),
      this.onBackground = const Color(0xff000000),
      this.surface = const Color(0xffffffff),
      this.onSurface = const Color(0xff000000),
      this.surfaceVariant = const Color(0xffe7e0ec),
      this.onSurfaceVariant = const Color(0xff49454e),
      this.outline = const Color(0xff79747f),
      this.shimmerBaseColor = const Color(0xFFF5F5F5),
      this.shimmerHighlightColor = const Color(0xFFE0E0E0),
      this.card = const Color(0xfff0f0f0),
      this.onCard = const Color(0xff495057),
      MaterialRadius? containerRadius,
      MaterialRadius? buttonRadius,
      MaterialRadius? textFieldRadius}) {
    this.containerRadius = containerRadius ?? MaterialRadius();
    this.buttonRadius = containerRadius ?? MaterialRadius();
    this.textFieldRadius = containerRadius ?? MaterialRadius();
  }

  MaterialThemeData copyWith(
      {Color? primary,
      Color? onPrimary,
      Color? primaryContainer,
      Color? onPrimaryContainer,
      Color? secondary,
      Color? onSecondary,
      Color? secondaryContainer,
      Color? onSecondaryContainer,
      Color? tertiary,
      Color? onTertiary,
      Color? tertiaryContainer,
      Color? onTertiaryContainer,
      Color? error,
      Color? onError,
      Color? errorContainer,
      Color? onErrorContainer,
      Color? background,
      Color? onBackground,
      Color? surface,
      Color? onSurface,
      Color? surfaceVariant,
      Color? onSurfaceVariant,
      Color? outline,
      Color? shimmerBaseColor,
      Color? shimmerHighlightColor,
      Color? card,
      Color? onCard,
      MaterialRadius? containerRadius,
      MaterialRadius? buttonRadius,
      MaterialRadius? textFieldRadius}) {
    this.primary = primary ?? this.primary;
    this.onPrimary = onPrimary ?? this.onPrimary;
    this.primaryContainer = primaryContainer ?? this.primaryContainer;
    this.onPrimaryContainer = onPrimaryContainer ?? this.onPrimaryContainer;
    this.secondary = secondary ?? this.secondary;
    this.onSecondary = onSecondary ?? this.onSecondary;
    this.secondaryContainer = secondaryContainer ?? this.secondaryContainer;
    this.onSecondaryContainer =
        onSecondaryContainer ?? this.onSecondaryContainer;
    this.tertiary = tertiary ?? this.tertiary;
    this.onTertiary = onTertiary ?? this.onTertiary;
    this.tertiaryContainer = tertiaryContainer ?? this.tertiaryContainer;
    this.onTertiaryContainer = onTertiaryContainer ?? this.onTertiaryContainer;
    this.error = error ?? this.error;
    this.onError = onError ?? this.onError;
    this.errorContainer = errorContainer ?? this.errorContainer;
    this.onErrorContainer = onErrorContainer ?? this.onErrorContainer;
    this.background = background ?? this.background;
    this.onBackground = onBackground ?? this.onBackground;
    this.surface = surface ?? this.surface;
    this.onSurface = onSurface ?? this.onSurface;
    this.surfaceVariant = surfaceVariant ?? this.surfaceVariant;
    this.onSurfaceVariant = onSurfaceVariant ?? this.onSurfaceVariant;
    this.outline = outline ?? this.outline;
    this.shimmerBaseColor = shimmerBaseColor ?? this.shimmerBaseColor;
    this.shimmerHighlightColor =
        shimmerHighlightColor ?? this.shimmerHighlightColor;
    this.card = card ?? this.card;
    this.onCard = onCard ?? this.onCard;
    this.containerRadius = containerRadius ?? MaterialRadius();
    this.buttonRadius = containerRadius ?? MaterialRadius();
    this.textFieldRadius = containerRadius ?? MaterialRadius();
    return this;
  }

  MaterialThemeData light() {
    return copyWith();
  }

  MaterialThemeData dark() {
    return copyWith(
        primary: Color(0xffd0bcff),
        onPrimary: Color(0xff381e73),
        primaryContainer: Color(0xff4f378b),
        onPrimaryContainer: Color(0xffeaddff),
        secondary: Color(0xffcbc2cb),
        onSecondary: Color(0xff332d41),
        secondaryContainer: Color(0xff4a4458),
        onSecondaryContainer: Color(0xffe8def8),
        tertiary: Color(0xffefb8c8),
        onTertiary: Color(0xff4a2532),
        tertiaryContainer: Color(0xff633b48),
        onTertiaryContainer: Color(0xfffbd8e4),
        error: Color(0xfff2b8b5),
        onError: Color(0xff601411),
        errorContainer: Color(0xff8c1d19),
        onErrorContainer: Color(0xfff9dedd),
        background: Color(0xff000000),
        onBackground: Color(0xffe6e1e5),
        surface: Color(0xff000000),
        onSurface: Color(0xffe6e1e5),
        surfaceVariant: Color(0xff494550),
        onSurfaceVariant: Color(0xffcac4d0),
        outline: Color(0xff948f9a),
        shimmerBaseColor: Color(0xFF1a1a1a),
        shimmerHighlightColor: Color(0xFF454545),
        card: Color(0xff222327),
        onCard: Color(0xfff3f3f3));
  }
}

class MaterialRadius {
  late double small, medium, large;

  MaterialRadius({double small = 8, double medium = 16, double large = 24}) {
    this.small = small;
    this.medium = medium;
    this.large = large;
  }
}
