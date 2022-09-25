import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:lottie/lottie.dart';

class EmptyDataV2 extends StatelessWidget {
  final String desc;
  final bool logout;
  final VoidCallback onpress;
  const EmptyDataV2(
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
                margin: EdgeInsets.only(top: 0),
                height: MediaQuery.of(context).size.width * 0.6,
                width: MediaQuery.of(context).size.width * 0.6,
                child: LottieBuilder.asset(
                  'assets/animation/empty-box.json',
                  frameRate: FrameRate.max,
                  repeat: true,
                )),
            Container(
              margin: EdgeInsets.only(top: 8),
              child: FxText.sh1(desc == '' ? "Tidak ada data" : desc,
                  color: themeData.colorScheme.onBackground,
                  fontWeight: 600,
                  letterSpacing: 0),
            ),
            this.logout == true
                ? Container(
                    margin: EdgeInsets.only(top: 24),
                    child: FxButton(
                        elevation: 0,
                        borderRadiusAll: 4,
                        onPressed: onpress,
                        child: FxText.b2("Logout",
                            fontWeight: 600,
                            color: themeData.colorScheme.onPrimary,
                            letterSpacing: 0.5)),
                  )
                : FxSpacing.height(50)
          ],
        ),
      ),
    );
  }
}
