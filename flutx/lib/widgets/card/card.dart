// Copyright 2021 The FlutX Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// There are mainly 2 types of card .
///
/// [FxCard.bordered] - provides border to the card.
/// [FxCard.rounded] - provides rounded shape to the card for the given height and width of the card.
///


import 'package:flutter/material.dart';
import 'package:flutx/styles/shadow.dart';
import 'package:flutx/themes/app_theme.dart';
import '../../utils/spacing.dart';
class FxCard extends StatelessWidget {
  final Widget child;
  final BorderRadius? borderRadius;
  final double? borderRadiusAll, paddingAll, marginAll;
  final EdgeInsetsGeometry? padding, margin;
  final Color? color;
  final GestureTapCallback? onTap;
  final bool bordered;
  final Border? border;
  final Clip? clipBehavior;
  final BoxShape? boxShape;
  final FxShadow? shadow;
  final double? width,height;
  final Color? splashColor;
  const FxCard(
      {Key? key,
        required this.child,
        this.borderRadius,
        this.padding,
        this.borderRadiusAll,
        this.color,
        this.paddingAll,
        this.onTap,
        this.border,
        this.bordered = false,
        this.clipBehavior,
        this.boxShape,
        this.shadow,
        this.marginAll,
        this.margin,
        this.splashColor, this.width, this.height})
      : super(key: key);
  const FxCard.bordered(
      {Key? key,
        required this.child,
        this.borderRadius,
        this.padding,
        this.borderRadiusAll,
        this.color,
        this.paddingAll,
        this.onTap,
        this.border,
        this.bordered = true,
        this.clipBehavior,
        this.boxShape,
        this.shadow,
        this.marginAll,
        this.margin,
        this.splashColor, this.width, this.height})
      : super(key: key);
  const FxCard.rounded(
      {Key? key,
        required this.child,
        this.borderRadius,
        this.padding,
        this.borderRadiusAll,
        this.color,
        this.paddingAll,
        this.onTap,
        this.border,
        this.bordered = false,
        this.clipBehavior = Clip.antiAliasWithSaveLayer,
        this.boxShape = BoxShape.circle,
        this.shadow,
        this.marginAll,
        this.margin,
        this.splashColor, this.width, this.height})
      : super(key: key);

  const FxCard.none(
      {Key? key,
        required this.child,
        this.borderRadius,
        this.padding,
        this.borderRadiusAll=0,
        this.color,
        this.paddingAll=0,
        this.onTap,
        this.border,
        this.bordered = false,
        this.clipBehavior = Clip.antiAliasWithSaveLayer,
        this.boxShape = BoxShape.rectangle,
        this.shadow,
        this.marginAll,
        this.margin,
        this.splashColor, this.width, this.height})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    FxShadow myShadow = shadow ?? FxShadow();
    return InkWell(
      borderRadius:  boxShape != BoxShape.circle
          ? borderRadius ??
          BorderRadius.all(Radius.circular(borderRadiusAll ?? 8))
          : null,
      splashColor: splashColor ?? Colors.transparent,
      highlightColor: splashColor ?? Colors.transparent,
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        margin: margin ?? FxSpacing.all(marginAll ?? 0),
        decoration: BoxDecoration(
            color: color ?? FxAppTheme.theme.cardTheme.color,
            borderRadius: boxShape != BoxShape.circle
                ? borderRadius ??
                BorderRadius.all(Radius.circular(borderRadiusAll ?? 8))
                : null,
            border: bordered
                ? border ??
                Border.all(color: FxAppTheme.theme.dividerColor, width: 1)
                : null,
            shape: boxShape ?? BoxShape.rectangle,
            boxShadow: [
              BoxShadow(
                  color: myShadow.color ??
                      FxAppTheme.theme.shadowColor.withAlpha(myShadow.alpha),
                  spreadRadius: myShadow.spreadRadius,
                  blurRadius: myShadow.blurRadius,
                  offset: myShadow.offset!)
            ]),
        padding: padding ?? FxSpacing.all(paddingAll ?? 16),
        clipBehavior: clipBehavior ?? Clip.none,
        child: child,
      ),
    );
  }
}