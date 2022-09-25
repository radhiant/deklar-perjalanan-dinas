import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:lottie/lottie.dart';

class NoInternet extends StatelessWidget {
  final String desc;
  final bool logout;
  final VoidCallback onpress;
  const NoInternet(
      {this.desc = '', this.logout = false, required this.onpress});

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Container(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(top: 100),
                height: MediaQuery.of(context).size.width * 0.4,
                width: MediaQuery.of(context).size.width * 0.4,
                child: LottieBuilder.asset(
                  'assets/animation/nointernet.json',
                  frameRate: FrameRate.max,
                  repeat: true,
                )),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: FxText.sh1(desc == '' ? "Tidak ada internet" : desc,
                  color: themeData.colorScheme.onBackground,
                  fontWeight: 600,
                  letterSpacing: 0),
            ),
            Container(
              margin: EdgeInsets.only(top: 24),
              child: FxButton(
                  elevation: 0,
                  borderRadiusAll: 4,
                  onPressed: onpress,
                  child: FxText.b2("Coba Lagi",
                      fontWeight: 600,
                      color: themeData.colorScheme.onPrimary,
                      letterSpacing: 0.5)),
            )
          ],
        ),
      ),
    );
  }
}
