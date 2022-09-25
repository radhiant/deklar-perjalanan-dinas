import 'dart:async';

import 'package:deklarasi/screens/login_screen.dart';
import 'package:deklarasi/theme/app_theme.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late CustomTheme customTheme;
  late ThemeData theme;
  bool isInProgress = true;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;

    startTimer();
  }

  void startTimer() {
    setState(() {
      isInProgress = true;
    });
    const oneSec = const Duration(seconds: 3);
    _timer = Timer.periodic(
        oneSec,
        (Timer timer) => {
              _timer.cancel(),
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()))
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              child: Image(
                  image: AssetImage(
                    './assets/brand/bku.png',
                  ),
                  height: MediaQuery.of(context).size.width * 0.5,
                  width: MediaQuery.of(context).size.width * 0.5),
            ),
          ],
        ),
      ),
    ));
  }
}
