import 'dart:math';
import 'package:flutter/material.dart';

class Generator {
  static const Color starColor = Color(0xfff9c700);
  static const Color goldColor = Color(0xffFFDF00);
  static const Color silverColor = Color(0xffC0C0C0);
  static const String _dummyText =
      "Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print, graphic or web designs. The passage is attributed to an unknown typesetter in the 15th century who is thought to have scrambled parts of Cicero's De Finibus Bonorum et Malorum for use in a type specimen book. There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc. Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print, graphic or web designs. The passage is attributed to an unknown typesetter in the 15th century who is thought to have scrambled parts of Cicero's De Finibus Bonorum et Malorum for use in a type specimen book. There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc";

  static const String _emojiText =
      "😀 😃 😄 😁 😆 😅 😂 🤣 😍 🥰 😘 😠 😡 💩 👻 🧐 🤓 😎 😋 😛 😝 😜 😢 😭 😤 🥱 😴 😾";

  static String randomString(int length) {
    var rand = new Random();
    var codeUnits = new List.generate(length, (index) {
      return rand.nextInt(33) + 89;
    });

    return new String.fromCharCodes(codeUnits);
  }

  static String getDummyText(int words,
      {bool withTab = false, bool withEmoji = false, withStop = true}) {
    var rand = new Random();
    List<String> dummyTexts = _dummyText.split(" ");

    if (withEmoji) {
      dummyTexts.addAll(_emojiText.split(" "));
    }

    int size = dummyTexts.length;
    String text = "";
    if (withTab) text += "\t\t\t\t";
    String firstWord = dummyTexts[rand.nextInt(size)];
    firstWord = firstWord[0].toUpperCase() + firstWord.substring(1);
    text += firstWord + " ";

    for (int i = 1; i < words; i++) {
      text += dummyTexts[rand.nextInt(size)] + (i == words - 1 ? "" : " ");
    }

    return text + (withStop ? "." : "");
  }

  static String getParagraphsText(
      {int paragraph = 1,
      int words = 20,
      int noOfNewLine = 1,
      bool withHyphen = false,
      bool withEmoji = false}) {
    String text = "";
    for (int i = 0; i < paragraph; i++) {
      if (withHyphen)
        text += "\t\t-\t\t";
      else
        text += "\t\t\t\t";
      text += getDummyText(words, withEmoji: withEmoji);
      if (i != paragraph - 1) {
        for (int j = 0; j < noOfNewLine; j++) {
          text += "\n";
        }
      }
    }
    return text;
  }

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

  static Widget buildOverlaysProfile(
      {double size = 50,
      required List<String> images,
      bool enabledOverlayBorder = false,
      Color overlayBorderColor = Colors.white,
      double overlayBorderThickness = 1,
      double leftFraction = 0.7,
      double topFraction = 0}) {
    double leftPlusSize = size * leftFraction;
    double topPlusSize = size * topFraction;
    double leftPosition = 0;
    double topPosition = 0;

    List<Widget> list = [];
    for (int i = 0; i < images.length; i++) {
      if (i == 0) {
        list.add(
          Container(
            decoration: enabledOverlayBorder
                ? BoxDecoration(
                    border: Border.all(
                        color: Colors.transparent,
                        width: overlayBorderThickness),
                    shape: BoxShape.circle)
                : BoxDecoration(),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(size / 2)),
              child: Image(
                image: AssetImage(images[i]),
                height: size,
                width: size,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      } else {
        leftPosition += leftPlusSize;
        topPosition += topPlusSize;
        list.add(Positioned(
          left: leftPosition,
          top: topPosition,
          child: Container(
            decoration: enabledOverlayBorder
                ? BoxDecoration(
                    border: Border.all(
                        color: overlayBorderColor,
                        width: overlayBorderThickness),
                    shape: BoxShape.circle)
                : BoxDecoration(),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(size / 2)),
              child: Image(
                image: AssetImage(images[i]),
                height: size,
                width: size,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ));
      }
    }
    double width =
        leftPosition + size + ((images.length) * overlayBorderThickness);
    double height =
        topPosition + size + ((images.length) * overlayBorderThickness);

    return Container(
      width: width,
      height: height,
      child: Stack(clipBehavior: Clip.none, children: list),
    );
  }
}
