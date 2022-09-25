import 'package:deklarasi/theme/theme_type.dart';

extension ThemeExtension on ThemeType {
  String get toText {
    return this == ThemeType.light ? "light" : "dark";
  }
}

extension StringExtension on String {
  ThemeType get toThemeType {
    return this == "dark" ? ThemeType.dark : ThemeType.light;
  }
}
