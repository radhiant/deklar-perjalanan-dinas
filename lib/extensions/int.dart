import 'package:deklarasi/theme/app_theme.dart';
import 'package:flutter/material.dart';

extension IntUtil on int {
  String textFromSeconds(
      {bool withZeros = false,
      bool withHours = false,
      bool withMinutes = false,
      bool withSeconds = false,
      bool withSpace = false}) {
    int time = this;
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
    if (withSeconds) {
      if (second < 10 && withZeros) {
        timeText += "0" + second.toString();
      } else {
        timeText += second.toString();
      }
    }

    return timeText;
  }

  int cd([int? alternative]) {
    return AppTheme.textDirection == TextDirection.ltr
        ? this
        : alternative ?? this;
  }
}
