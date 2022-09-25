import 'package:deklarasi/widgets/form_expenditure.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

class ExpenditureBottomsheet extends StatelessWidget {
  final Iterable<dynamic> data;
  ExpenditureBottomsheet({required this.data});

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Container(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            color: themeData.backgroundColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16))),
        child: Padding(
          padding: FxSpacing.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                  onTap: () {
                    Navigator.of(context).pop('update');
                  },
                  dense: true,
                  leading: Icon(Icons.edit, color: Colors.green),
                  title: FxText.b1("Ubah", fontWeight: 600)),
              ListTile(
                  onTap: () => Navigator.of(context).pop('delete'),
                  dense: true,
                  leading: Icon(
                    Icons.delete_outline,
                    color: themeData.colorScheme.error,
                  ),
                  title: FxText.b1("Hapus", fontWeight: 600)),
            ],
          ),
        ),
      ),
    );
  }
}
