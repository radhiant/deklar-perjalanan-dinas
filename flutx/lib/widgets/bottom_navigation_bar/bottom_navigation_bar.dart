// Copyright 2021 The FlutX Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// There are mainly 2 types of bottomNavigationbar implemented using material Widgets.
///
/// [FxBottomNavigationBarType.normal] -  In this, the bottom items/Icons can be highlighted in a normal way.
/// [FxBottomNavigationBarType.containered] -  In this, the bottom items/Icons are kept in a container with text accompanied  by the icons.
///

import 'package:flutter/material.dart';
import 'package:flutx/themes/app_theme.dart';
import 'package:flutx/themes/text_style.dart';
import 'package:flutx/utils/spacing.dart';
import 'package:flutx/widgets/container/container.dart';

import 'bottom_navigation_bar_item.dart';

export 'bottom_navigation_bar_item.dart';

enum FxBottomNavigationBarType {
  normal,
  containered,
}

class FxBottomNavigationBar extends StatefulWidget {
  final List<FxBottomNavigationBarItem>? itemList;
  final Duration? animationDuration;
  final Color? indicatorColor;
  final double? indicatorSize;
  final Decoration? indicatorDecoration;
  final FxBottomNavigationBarType? fxBottomNavigationBarType;
  final bool showLabel;
  final bool? showActiveLabel;
  final Color? activeContainerColor;
  final Color? backgroundColor;
  final Axis? labelDirection;
  final double labelSpacing;
  final TextStyle? activeTitleStyle;
  final TextStyle? titleStyle;
  final int initialIndex;
  final Decoration? containerDecoration;
  final BoxShape? containerShape;
  final Color? activeTitleColor;
  final Color? titleColor;
  final double? activeTitleSize;
  final double? titleSize;
  final Color? iconColor;
  final Color? activeIconColor;
  final double? iconSize;
  final double? activeIconSize;
  final EdgeInsetsGeometry? outerPadding;
  final EdgeInsetsGeometry? outerMargin;
  final EdgeInsetsGeometry? containerPadding;
  final double? containerRadius;

  FxBottomNavigationBar(
      {required this.itemList,
      this.animationDuration,
      this.indicatorColor,
      this.indicatorSize,
      this.indicatorDecoration,
      this.fxBottomNavigationBarType,
      this.showLabel = true,
      this.activeContainerColor,
      this.backgroundColor,
      this.showActiveLabel,
      this.labelDirection = Axis.horizontal,
      this.labelSpacing = 8,
      this.activeTitleStyle,
      this.titleStyle,
      this.initialIndex = 0,
      this.activeTitleColor,
      this.titleColor,
      this.activeTitleSize,
      this.titleSize,
      this.iconColor,
      this.activeIconColor,
      this.iconSize,
      this.activeIconSize,
      this.containerDecoration,
      this.containerShape,
        this.outerPadding,
        this.outerMargin,
        this.containerRadius,
        this.containerPadding
      });

  @override
  _FxBottomNavigationBarState createState() => _FxBottomNavigationBarState();
}

class _FxBottomNavigationBarState extends State<FxBottomNavigationBar>
    with SingleTickerProviderStateMixin {
  late List<FxBottomNavigationBarItem>? itemList;
  late int _currentIndex;
  late Duration? animationDuration;
  late TabController? _tabController;
  late Color? indicatorColor;
  late double? indicatorSize;
  late Decoration? indicatorDecoration;
  late FxBottomNavigationBarType? fxBottomNavigationBarType;
  late bool showLabel;
  late bool showActiveLabel;
  late Color? activeContainerColor;
  late Color? backgroundColor;
  late Decoration? containerDecoration;
  late BoxShape? containerShape;
  late TextStyle? activeTitleStyle;
  late TextStyle? titleStyle;
  late Color? activeTitleColor;
  late Color? titleColor;
  late double? activeTitleSize;
  late Color? iconColor;
  late Color? activeIconColor;
  late double? iconSize;
  late double? activeIconSize;
  late EdgeInsetsGeometry? outerPadding;
  late EdgeInsetsGeometry? containerPadding;
  late EdgeInsetsGeometry? outerMargin;
  late double? containerRadius;

  _handleTabSelection() {
    setState(() {
      _currentIndex = _tabController!.index;
    });
  }

  @override
  void initState() {
    itemList = widget.itemList;
    _currentIndex = widget.initialIndex;
    _tabController = new TabController(
        length: itemList!.length,
        initialIndex: widget.initialIndex,
        vsync: this);
    _tabController!.addListener(_handleTabSelection);
    _tabController!.animation!.addListener(() {
      final animationValue = _tabController!.animation!.value;
      if (animationValue - _currentIndex > 0.5) {
        setState(() {
          _currentIndex = _currentIndex + 1;
        });
      } else if (animationValue - _currentIndex < -0.5) {
        setState(() {
          _currentIndex = _currentIndex - 1;
        });
      }
    });
    super.initState();
  }

  dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  List<Widget> getListOfViews() {
    List<Widget> viewList = [];
    for (int i = 0; i < itemList!.length; i++) {
      viewList.add(itemList![i].page!);
    }
    return viewList;
  }

  Widget getItem(int index) {
    FxBottomNavigationBarItem item = itemList![index];

    if (fxBottomNavigationBarType == FxBottomNavigationBarType.normal) {
      return Container(
        child: (_currentIndex == index)
            ? Wrap(
                direction: widget.labelDirection!,
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  item.activeIcon ??
                      Icon(
                        item.activeIconData,
                        size: activeIconSize ?? item.activeIconSize ?? 14,
                        color: activeIconColor ??
                            item.activeIconColor ??
                            FxAppTheme.theme.primaryColor,
                      ),
                  widget.labelDirection == Axis.horizontal
                      ? FxSpacing.width(
                          showActiveLabel ? widget.labelSpacing : 0)
                      : FxSpacing.height(
                          showActiveLabel ? widget.labelSpacing : 0),
                  showActiveLabel
                      ? Text(
                          item.title!,
                          style: activeTitleStyle ??
                              item.activeTitleStyle ??
                              FxTextStyle.caption(
                                  color: activeTitleColor ??
                                      item.activeTitleColor ??
                                      FxAppTheme.theme.primaryColor,
                                  fontSize:
                                      activeTitleSize ?? item.activeTitleSize),
                        )
                      : Container(),
                ],
              )
            : Wrap(
                direction: widget.labelDirection!,
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  item.icon ??
                      Icon(
                        item.iconData,
                        size: iconSize ?? item.iconSize ?? 14,
                        color: iconColor ??
                            item.iconColor ??
                            FxAppTheme.theme.colorScheme.onBackground,
                      ),
                  widget.labelDirection == Axis.horizontal
                      ? FxSpacing.width(showLabel ? widget.labelSpacing : 0)
                      : FxSpacing.height(showLabel ? widget.labelSpacing : 0),
                  showLabel
                      ? Text(
                          item.title!,
                          style: titleStyle ??
                              item.titleStyle ??
                              FxTextStyle.caption(
                                  color: titleColor ??
                                      item.titleColor ??
                                      FxAppTheme.theme.colorScheme.onBackground,
                                  fontSize: widget.titleSize ?? item.titleSize),
                        )
                      : Container(),
                ],
              ),
      );
    } else {
      Widget iconWidget;
      if (item.activeIcon != null) {
        iconWidget = item.activeIcon!;
      } else {
        iconWidget = Icon(
          item.activeIconData ?? item.iconData,
          size: activeIconSize ?? item.activeIconSize ?? 24,
          color: activeIconColor ??
              item.activeIconColor ??
              FxAppTheme.theme.primaryColor,
        );
      }

      return (_currentIndex == index)
          ? FxContainer(
             padding: containerPadding??FxSpacing.all(8),

              borderRadiusAll: containerRadius??8,
              shape: containerShape??BoxShape.rectangle,
              color: activeContainerColor,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  iconWidget,
                  FxSpacing.width(showActiveLabel ? 8 : 0),
                  showActiveLabel
                      ? Text(
                          item.title!,
                          style: activeTitleStyle ??
                              item.activeTitleStyle ??
                              FxTextStyle.caption(
                                  color: activeTitleColor ??
                                      item.activeTitleColor ??
                                      FxAppTheme.theme.primaryColor,
                                  fontSize:
                                      activeTitleSize ?? item.activeTitleSize),
                        )
                      : Container(),
                ],
              ),
            )
          : item.icon ??
              Icon(
                item.iconData,
                size: iconSize ?? item.iconSize ?? 24,
                color: iconColor ??
                    item.iconColor ??
                    FxAppTheme.theme.colorScheme.onBackground.withAlpha(150),
              );
    }
  }

  List<Widget> getListOfItems() {
    List<Widget> list = [];

    double singleWidth = (MediaQuery.of(context).size.width - 50) /
        (itemList!.length +
            (widget.showLabel ? 0 : (showActiveLabel ? 0.5 : 0)));

    for (int i = 0; i < itemList!.length; i++) {
      double containerWidth = widget.showLabel
          ? (singleWidth)
          : (showActiveLabel
              ? (i == _currentIndex ? singleWidth * 1.5 : singleWidth)
              : singleWidth);
      list.add(Container(
        width: containerWidth,
        child: InkWell(
          child: Center(child: getItem(i)),
          onTap: () {
            setState(() {
              _currentIndex = i;
              _tabController!.index = i;
            });
          },
        ),
      ));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    // animationDuration=widget.animationDuration!;
    indicatorColor = widget.indicatorColor ?? FxAppTheme.theme.primaryColor;
    indicatorSize = widget.indicatorSize;
    indicatorDecoration = widget.indicatorDecoration;
    fxBottomNavigationBarType =
        widget.fxBottomNavigationBarType ?? FxBottomNavigationBarType.normal;
    showLabel = widget.showLabel;
    showActiveLabel = widget.showActiveLabel ?? true;
    activeContainerColor = widget.activeContainerColor ??
        FxAppTheme.theme.primaryColor.withAlpha(100);
    backgroundColor =
        widget.backgroundColor ?? FxAppTheme.theme.backgroundColor;
    activeTitleStyle = widget.activeTitleStyle;
    titleStyle = widget.titleStyle;
    activeTitleColor = widget.activeTitleColor;
    titleColor = widget.titleColor;
    activeTitleSize = widget.activeTitleSize;
    iconColor = widget.iconColor;
    activeIconColor = widget.activeIconColor;
    iconSize = widget.iconSize;
    activeIconSize = widget.activeIconSize;
    containerDecoration = widget.containerDecoration;
    containerShape = widget.containerShape;
    outerPadding = widget.outerPadding;
    outerMargin = widget.outerMargin;
    containerRadius=widget.containerRadius;
    containerPadding=widget.containerPadding;

    return Column(
      children: [
        Expanded(
          child: TabBarView(
            physics: ClampingScrollPhysics(),
            controller: _tabController,
            children: getListOfViews(),
          ),
        ),
        Container(
          padding: outerPadding??FxSpacing.all(16),
          margin: outerMargin??FxSpacing.zero,
          decoration: containerDecoration ??
              BoxDecoration(
                color: backgroundColor,
              ),
          child: Row(
            children: getListOfItems(),
          ),
        ),
      ],
    );
  }
}
