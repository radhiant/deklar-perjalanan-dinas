import 'package:deklarasi/theme/app_notifier.dart';
import 'package:deklarasi/theme/app_theme.dart';
import 'package:deklarasi/theme/theme_type.dart';
import 'package:flutter/material.dart';
import 'package:flutx/icons/two_tone/two_tone_icon.dart';
import 'package:flutx/widgets/button/button.dart';
import 'package:provider/provider.dart';

class ChangeTheme extends StatefulWidget {
  const ChangeTheme({Key? key}) : super(key: key);

  @override
  _ChangeThemeState createState() => _ChangeThemeState();
}

class _ChangeThemeState extends State<ChangeTheme> {
  String themeType = "";

  @override
  void initState() {
    super.initState();
    if (AppTheme.themeType == ThemeType.light) {
      themeType = "dark";
    } else {
      themeType = "light";
    }
  }

  void changeTheme() {
    if (AppTheme.themeType == ThemeType.light) {
      Provider.of<AppNotifier>(context, listen: false)
          .updateTheme(ThemeType.dark);
      setState(() {
        themeType = "light";
      });
    } else {
      Provider.of<AppNotifier>(context, listen: false)
          .updateTheme(ThemeType.light);
      setState(() {
        themeType = "dark";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FxButton.medium(
      onPressed: () {
        changeTheme();
      },
      elevation: 0,
      child: FxTwoToneIcon(
          themeType == "dark"
              ? FxTwoToneMdiIcons.brightness_2
              : FxTwoToneMdiIcons.brightness_5,
          color: Colors.grey),
      buttonType: FxButtonType.text,
      splashColor: Colors.grey,
    );
  }
}
