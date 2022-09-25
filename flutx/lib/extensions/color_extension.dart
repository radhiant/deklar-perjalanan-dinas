import 'package:flutter/material.dart';

extension ColorExtension on Color {
  double get brightness {
    return (0.299 * (this.red) + 0.587 * (this.green) + 0.114 * (this.blue)) /
        2.55;
  }
}
