// Copyright 2021 The FlutX Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// [FxCustomRating] - able to give customisable rating widget with custom features.

import 'package:flutter/material.dart';
import 'package:flutx/utils/color_utils.dart';

typedef void OnRatingChange(int rating);

class FxCustomRating extends StatefulWidget {
  final int initialRating = 3;
  final double? starSize, starSpacing;
  final List<Color>? starColors;
  final Color inactiveStarColor;
  final OnRatingChange onRatingChange;

  const FxCustomRating(
      {Key? key,
      this.starSize = 24,
      this.starSpacing = 8,
      this.starColors,
      required this.onRatingChange,
      this.inactiveStarColor = Colors.grey})
      : super(key: key);

  @override
  _FxCustomRatingState createState() => _FxCustomRatingState();
}

class _FxCustomRatingState extends State<FxCustomRating> {

  late int rating;
  late List<Color> starColors;

  @override
  void initState() {
    rating = widget.initialRating;

    super.initState();
  }

  buildStar() {
    starColors = widget.starColors ?? FxColorUtils.getColorByRating();
    List<Widget> list = [];
    for (int i = 1; i < 6; i++) {
      list.add(InkWell(
        onTap: () {
          setState(() {
            rating = i;
          });
          widget.onRatingChange(i);
        },
        child: Icon(rating >= i ? Icons.star : Icons.star_outline,
            size: widget.starSize,
            color: rating >= i
                ? starColors[rating - 1]
                : widget.inactiveStarColor),
      ));
      if (i != 5) {
        list.add(SizedBox(
          width: widget.starSpacing,
        ),);
      }
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: buildStar(),
      ),
    );
  }
}
