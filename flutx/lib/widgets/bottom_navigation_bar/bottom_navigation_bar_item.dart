import 'package:flutter/material.dart';

class FxBottomNavigationBarItem{

  final String? title;

  final TextStyle? activeTitleStyle;
  final TextStyle? titleStyle;
  final Color? activeTitleColor;
  final Color? titleColor;
  final double? activeTitleSize;
  final double? titleSize;
  final Color? iconColor;
  final Color? activeIconColor;
  final double? iconSize;
  final double? activeIconSize;

  final IconData? iconData;
  final IconData? activeIconData;
  final Widget? icon;
  final Widget? activeIcon;
  final Widget? page;


  FxBottomNavigationBarItem({required this.page,
      this.title,
      this.activeTitleStyle,
      this.titleStyle,
      this.activeTitleColor,
      this.titleColor,
      this.activeTitleSize,
      this.titleSize,
      this.iconData,
      this.activeIconData,
      this.icon,
      this.activeIcon,
      this.iconColor,
      this.activeIconColor,
      this.iconSize,
      this.activeIconSize});


}