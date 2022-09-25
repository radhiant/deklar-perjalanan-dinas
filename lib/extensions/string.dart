import 'dart:ui';

import 'package:deklarasi/localizations/translator.dart';

extension StringUtil on String {
  Color get toColor {
    String data = this.replaceAll("#", "");
    if (data.length == 6) {
      data = "FF" + data;
    }
    return Color(int.parse("0x$data"));
  }

  String maxLength(int length) {
    if (length > this.length)
      return this;
    else
      return this.substring(0, length);
  }

  String toParagraph([bool addDash = false]) {
    return addDash ? "-\t" + this : "\t" + this;
  }

  bool toBool([bool defaultValue = false]) {
    if (this.toString().compareTo('1') == 0 ||
        this.toString().compareTo('true') == 0) {
      return true;
    } else if (this.toString().compareTo('0') == 0 ||
        this.toString().compareTo('false') == 0) {
      return false;
    }
    return defaultValue;
  }

  int? toInt([int? defaultValue]) {
    try {
      return int.parse(this);
    } catch (e) {
      return defaultValue;
    }
  }

  double? toDouble([double? defaultValue]) {
    try {
      return double.parse(this);
    } catch (e) {
      return defaultValue;
    }
  }
}

//------ App Localization Extension --------------------------//

extension StringLocalization on String {
  String tr() {
    return Translator.translate(this);
  }
}
