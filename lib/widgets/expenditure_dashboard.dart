import 'package:deklarasi/utils/formatcurrency.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

class ExpenditureDashboard extends StatelessWidget {
  final Color backgroundColor;
  final String subject;
  final int value;
  final bool isNum;

  const ExpenditureDashboard(
      {Key? key,
      required this.backgroundColor,
      required this.subject,
      this.value = 0,
      this.isNum = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FxContainer.none(
      borderRadiusAll: 4,
      color: backgroundColor,
      height: 125,
      child: Container(
        padding: EdgeInsets.only(bottom: 20, left: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            this.isNum == false
                ? FxText.sh1(FormatCurrency.convertToIdr(this.value, 0),
                    fontWeight: 700,
                    color: Colors.white,
                    fontSize: this.value >= 10000000 ? 18 : 20)
                : FxText.sh1(this.value.toString(),
                    fontWeight: 700,
                    color: Colors.white,
                    fontSize: this.value >= 10000000 ? 18 : 20),
            FxSpacing.height(16),
            FxText.sh1(subject, fontWeight: 500, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
