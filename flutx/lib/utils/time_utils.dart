// Copyright 2021 The FlutX Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// [FxTimeUtils] - provides different functions for formatting time

class FxTimeUtils{
  static String getTextFromSeconds(
      {int time = 0,
        bool withZeros = true,
        bool withHours = true,
        bool withMinutes = true,
        bool withSpace = true}) {
    int hour = (time / 3600).floor();
    int minute = ((time - 3600 * hour) / 60).floor();
    int second = (time - 3600 * hour - 60 * minute);

    String timeText = "";

    if (withHours && hour != 0) {
      if (hour < 10 && withZeros) {
        timeText += "0" + hour.toString() + (withSpace ? " : " : ":");
      } else {
        timeText += hour.toString() + (withSpace ? " : " : "");
      }
    }

    if (withMinutes) {
      if (minute < 10 && withZeros) {
        timeText += "0" + minute.toString() + (withSpace ? " : " : ":");
      } else {
        timeText += minute.toString() + (withSpace ? " : " : "");
      }
    }

    if (second < 10 && withZeros) {
      timeText += "0" + second.toString();
    } else {
      timeText += second.toString();
    }

    return timeText;
  }

}
