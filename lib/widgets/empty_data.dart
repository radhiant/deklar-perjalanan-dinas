import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

class EmptyData extends StatelessWidget {
  final String desc;
  final bool logout;
  final VoidCallback onpress;
  const EmptyData({this.desc = '', this.logout = false, required this.onpress});

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Container(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 72),
              child: Image(
                  image: AssetImage(
                    './assets/other/inbox.png',
                  ),
                  height: MediaQuery.of(context).size.width * 0.3,
                  width: MediaQuery.of(context).size.width * 0.3),
            ),
            Container(
              margin: EdgeInsets.only(top: 24),
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
