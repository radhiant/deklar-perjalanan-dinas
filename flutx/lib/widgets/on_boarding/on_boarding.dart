// Copyright 2021 The FlutX Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// [FxOnBoarding] - Gives a custom page onBoarding widget with 2 buttons for SKIP and DONE.


import 'dart:async';
import 'package:flutter/material.dart';
import 'animation_gesture/page_dragger.dart';
import 'animation_gesture/page_reveal.dart';
import 'ui/pager_indicator.dart';
import 'ui/pages.dart';

export 'ui/pages.dart';
export 'ui/pager_indicator.dart';

class FxOnBoarding extends StatefulWidget {
  final List<PageViewModel> pages;
  final Color selectedIndicatorColor;
  final Color unSelectedIndicatorColor;
  final Widget skipWidget,doneWidget;

  const FxOnBoarding({Key? key, required this.pages, required this.selectedIndicatorColor, required this.unSelectedIndicatorColor, required this.skipWidget, required this.doneWidget}) : super(key: key);

  @override
  _FxOnBoardingState createState() => new _FxOnBoardingState();
}

class _FxOnBoardingState extends State<FxOnBoarding>
    with TickerProviderStateMixin {
  StreamController<SlideUpdate>? slideUpdateStream;
  AnimatedPageDragger? animatedPageDragger;

  int activeIndex = 0;

  SlideDirection? slideDirection = SlideDirection.none;
  int nextPageIndex = 0;

  double? slidePercent = 0.0;

  _FxOnBoardingState() {
    slideUpdateStream = new StreamController<SlideUpdate>();

    slideUpdateStream!.stream.listen((SlideUpdate event) {
      setState(() {
        if (event.updateType == UpdateType.dragging) {
          slideDirection = event.direction;
          slidePercent = event.slidePercent;

          if (slideDirection == SlideDirection.leftToRight) {
            nextPageIndex = activeIndex - 1;
          } else if (slideDirection == SlideDirection.rightToLeft) {
            nextPageIndex = activeIndex + 1;
          } else {
            nextPageIndex = activeIndex;
          }
        } else if (event.updateType == UpdateType.doneDragging) {
          if (slidePercent! > 0.5) {
            animatedPageDragger = new AnimatedPageDragger(
              slideDirection: slideDirection,
              transitionGoal: TransitionGoal.open,
              slidePercent: slidePercent,
              slideUpdateStream: slideUpdateStream,
              vsync: this,
            );
          } else {
            animatedPageDragger = new AnimatedPageDragger(
              slideDirection: slideDirection,
              transitionGoal: TransitionGoal.close,
              slidePercent: slidePercent,
              slideUpdateStream: slideUpdateStream,
              vsync: this,
            );
          }

          animatedPageDragger!.run();
        } else if (event.updateType == UpdateType.animating) {
          slideDirection = event.direction;
          slidePercent = event.slidePercent;
        } else if (event.updateType == UpdateType.doneAnimating) {
          if (animatedPageDragger?.transitionGoal == TransitionGoal.open) {
            activeIndex = nextPageIndex;
          }
          slideDirection = SlideDirection.none;
          slidePercent = 0.0;

          animatedPageDragger!.dispose();
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    slideUpdateStream!.close();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.black,
      body: new Stack(
        children: [
          FxSinglePage(
            viewModel: widget.pages[activeIndex],
            percentVisible: 1.0,
          ),
          new FxPageReveal(
            revealPercent: slidePercent,
            child: new FxSinglePage(
              viewModel: widget.pages[nextPageIndex],
              percentVisible: slidePercent,
            ),
          ),
          new FxPagerIndicator(
            viewModel: new PagerIndicatorViewModel(
                widget.pages,
                activeIndex,
                slideDirection,
                slidePercent,
                widget.selectedIndicatorColor,
                widget.unSelectedIndicatorColor,
                widget.skipWidget,
                widget.doneWidget
            ),
          ),
          new FxPageDragger(
            canDragLeftToRight: activeIndex > 0,
            canDragRightToLeft: activeIndex < widget.pages.length - 1,
            slideUpdateStream: this.slideUpdateStream,
          )
        ],
      ),
    );
  }
}