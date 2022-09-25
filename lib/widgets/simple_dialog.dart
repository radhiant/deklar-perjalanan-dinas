import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

class SimpleDialogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: Container(
        padding: FxSpacing.all(16),
        decoration: BoxDecoration(
          color: themeData.backgroundColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
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
            FxSpacing.height(20),
            CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
              themeData.colorScheme.primary,
            )),
            FxSpacing.height(20),
            FxText.sh1("Memuat..", fontWeight: 600),
            FxSpacing.height(20),
          ],
        ),
      ),
    );
  }
}
