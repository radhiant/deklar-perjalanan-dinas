import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:lottie/lottie.dart';

class SinkronisasiDialog extends StatelessWidget {
  final String title, desc;
  SinkronisasiDialog({required this.title, required this.desc});

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
          crossAxisAlignment: CrossAxisAlignment.start,
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
              margin: FxSpacing.top(0),
              child: Center(child: FxText.sh1(title, fontWeight: 700)),
            ),
            Container(
              margin: FxSpacing.top(16),
              child: Center(child: FxText.caption(desc, fontWeight: 600)),
            ),
            Container(
                margin: FxSpacing.top(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FxButton(
                        backgroundColor: themeData.colorScheme.error,
                        elevation: 0,
                        borderRadiusAll: 4,
                        onPressed: () {
                          Navigator.of(context).pop("batal");
                        },
                        child: FxText.caption("Batal",
                            fontWeight: 600,
                            letterSpacing: 0.4,
                            color: themeData.colorScheme.onPrimary)),
                    FxSpacing.width(16),
                    FxButton(
                        backgroundColor: themeData.colorScheme.primary,
                        elevation: 0,
                        borderRadiusAll: 4,
                        onPressed: () {
                          Navigator.of(context).pop("konfirmasi");
                        },
                        child: FxText.caption("Konfirmasi",
                            fontWeight: 600,
                            letterSpacing: 0.4,
                            color: themeData.colorScheme.onPrimary))
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
