import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

class SinkronisasiBottomsheet extends StatelessWidget {
  final String data;
  SinkronisasiBottomsheet({this.data = ""});

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
                    Navigator.of(context).pop("upload");
                  },
                  dense: true,
                  leading: Icon(Icons.upload,
                      color: themeData.colorScheme.onBackground),
                  title: FxText.b1("Upload", fontWeight: 600)),
              ListTile(
                  onTap: () {
                    Navigator.of(context).pop("download");
                  },
                  dense: true,
                  leading: Icon(
                    Icons.download,
                    color: themeData.colorScheme.onBackground,
                  ),
                  title: FxText.b1("Download", fontWeight: 600)),
            ],
          ),
        ),
      ),
    );
  }
}
