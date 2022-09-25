/*
* File : Custom Chat Theme
* Version : 1.0.0
* */

import 'package:flutter/material.dart';

class CustomChatTheme {
  Color? backgroundColor,
      textFieldBackground,
      textOnTextField,
      hintTextOnTextField,
      iconOnTextField,
      btnColor,
      iconOnBtn,
      myChatBG,
      chatBG,
      onMyChat,
      onChat,
      appBarColor,
      onAppBar,
      onBackground,
      tickColor;

  static CustomChatTheme getWhatsAppTheme() {
    CustomChatTheme customChatTheme = CustomChatTheme();
    customChatTheme.backgroundColor = const Color(0xff343940);
    customChatTheme.textFieldBackground = const Color(0xff37404a);
    customChatTheme.textOnTextField = const Color(0xffebebeb);
    customChatTheme.hintTextOnTextField = const Color(0xffc2c2c2);
    customChatTheme.iconOnTextField = const Color(0xffb3b3b3);
    customChatTheme.btnColor = const Color(0xff01877c);
    customChatTheme.iconOnBtn = const Color(0xffebebeb);
    customChatTheme.myChatBG = const Color(0xff054640);
    customChatTheme.chatBG = const Color(0xff212e36);
    customChatTheme.onMyChat = const Color(0xfff5f5f5);
    customChatTheme.onChat = const Color(0xfff5f5f5);
    customChatTheme.appBarColor = const Color(0xff2e343b);
    customChatTheme.onAppBar = Colors.white;
    customChatTheme.onBackground = const Color(0xfff5f5f5);
    customChatTheme.tickColor = const Color(0xff33a3ca);

    return customChatTheme;
  }

  static CustomChatTheme getFacebookTheme() {
    CustomChatTheme customChatTheme = CustomChatTheme();
    customChatTheme.backgroundColor = const Color(0xff000000);
    customChatTheme.textFieldBackground = const Color(0xff333333);
    customChatTheme.textOnTextField = const Color(0xffebebeb);
    customChatTheme.hintTextOnTextField = const Color(0xffc2c2c2);
    customChatTheme.iconOnTextField = const Color(0xffb3b3b3);
    customChatTheme.btnColor = const Color(0xff0084ff);
    customChatTheme.iconOnBtn = const Color(0xffebebeb);
    customChatTheme.myChatBG = const Color(0xff0084ff);
    customChatTheme.chatBG = const Color(0xff333333);
    customChatTheme.onMyChat = const Color(0xfff5f5f5);
    customChatTheme.onChat = const Color(0xfff5f5f5);
    customChatTheme.appBarColor = const Color(0xff000000);
    customChatTheme.onAppBar = Colors.white;
    customChatTheme.onBackground = const Color(0xfff5f5f5);

    return customChatTheme;
  }
}
