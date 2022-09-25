import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

class AlertLoading extends StatelessWidget {
  final String title;
  AlertLoading({this.title = "Memuat.."});

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
              padding: FxSpacing.y(18),
              child: Center(
                child: Column(
                  children: <Widget>[
                    CircularProgressIndicator(),
                    FxSpacing.height(16),
                    FxText.caption(this.title, fontWeight: 600),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
