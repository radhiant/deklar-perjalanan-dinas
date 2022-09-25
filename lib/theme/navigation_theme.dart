import 'package:deklarasi/theme/theme_type.dart';
import 'package:flutter/material.dart';

import 'app_theme.dart';

class NavigationTheme {
  Color? backgroundColor,
      selectedItemIconColor,
      selectedItemTextColor,
      selectedItemColor,
      selectedOverlayColor,
      unselectedItemIconColor,
      unselectedItemTextColor,
      unselectedItemColor;

  static NavigationTheme getNavigationTheme([ThemeType? themeType]) {
    NavigationTheme navigationBarTheme = NavigationTheme();
    themeType = themeType ?? AppTheme.themeType;
    if (themeType == ThemeType.light) {
      navigationBarTheme.backgroundColor = Colors.white;
      navigationBarTheme.selectedItemColor = Color(0xff3d63ff);
      navigationBarTheme.unselectedItemColor = Color(0xff495057);
      navigationBarTheme.selectedOverlayColor = Color(0x383d63ff);
    } else {
      navigationBarTheme.backgroundColor = Color(0xff37404a);
      navigationBarTheme.selectedItemColor = Color(0xff37404a);
      navigationBarTheme.unselectedItemColor = Color(0xffd1d1d1);
      navigationBarTheme.selectedOverlayColor = Color(0xffffffff);
    }
    return navigationBarTheme;
  }
}
