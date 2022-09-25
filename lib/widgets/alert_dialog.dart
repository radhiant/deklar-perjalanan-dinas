import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:lottie/lottie.dart';

class AlertDialogScreen extends StatelessWidget {
  final String title;
  final bool status;
  AlertDialogScreen({required this.title, this.status = false});

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
              margin: FxSpacing.top(16),
              child: Center(child: FxText.sh1(this.title, fontWeight: 700)),
            ),
            Container(
              margin: FxSpacing.top(16),
              child: Center(
                  child: FxText.caption("Silahkan cek user dan password anda!",
                      fontWeight: 600)),
            ),
            Container(
              margin: FxSpacing.top(16),
              child: Center(
                child: FxButton(
                    backgroundColor: themeData.colorScheme.primary,
                    elevation: 0,
                    borderRadiusAll: 4,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: FxText.caption("OK",
                        fontWeight: 600,
                        letterSpacing: 0.4,
                        color: themeData.colorScheme.onPrimary)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
