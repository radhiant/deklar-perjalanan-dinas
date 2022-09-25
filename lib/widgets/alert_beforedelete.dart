import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:lottie/lottie.dart';

class AlertBeforeDelete extends StatelessWidget {
  final String title;
  AlertBeforeDelete({required this.title});

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Dialog(
      child: Container(
        padding: FxSpacing.xy(24, 16),
        decoration: BoxDecoration(
          color: themeData.backgroundColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Center(
                  child: SizedBox(
                width: 125,
                height: 125,
                child: LottieBuilder.asset('assets/animation/warning.json'),
              )),
            ),
            Container(
              alignment: Alignment.center,
              // color: Colors.red,
              margin: FxSpacing.top(0),
              width: MediaQuery.of(context).size.width * 1,
              child: FxText.sh1(this.title,
                  textAlign: TextAlign.center, fontWeight: 700),
            ),
            Container(
              margin: FxSpacing.top(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FxButton(
                      backgroundColor: Colors.redAccent,
                      elevation: 0,
                      borderRadiusAll: 4,
                      onPressed: () {
                        Navigator.of(context).pop("batal");
                      },
                      child: FxText.caption("Batal",
                          fontWeight: 600,
                          letterSpacing: 0.4,
                          color: themeData.colorScheme.onPrimary)),
                  FxSpacing.width(8),
                  FxButton(
                      backgroundColor: themeData.colorScheme.primary,
                      elevation: 0,
                      borderRadiusAll: 4,
                      onPressed: () {
                        Navigator.of(context).pop("yakin");
                      },
                      child: FxText.caption("Iya",
                          fontWeight: 600,
                          letterSpacing: 0.4,
                          color: themeData.colorScheme.onPrimary)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
