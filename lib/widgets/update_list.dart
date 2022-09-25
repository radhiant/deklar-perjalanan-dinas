import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:lottie/lottie.dart';

import '../theme/app_theme.dart';

class UpdateList extends StatefulWidget {
  final String name, versi, ket, progress;
  final VoidCallback onpress;
  const UpdateList(
      {Key? key,
      required this.name,
      required this.versi,
      required this.ket,
      required this.progress,
      required this.onpress})
      : super(key: key);

  @override
  State<UpdateList> createState() => _UpdateListState();
}

class _UpdateListState extends State<UpdateList> {
  late ThemeData theme;
  late CustomTheme customTheme;

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    customTheme = AppTheme.customTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.only(top: 24, bottom: 0),
            child: Container(
                margin: EdgeInsets.only(top: 0),
                height: MediaQuery.of(context).size.width * 0.6,
                width: MediaQuery.of(context).size.width * 0.6,
                child: LottieBuilder.asset(
                  'assets/animation/update.json',
                  frameRate: FrameRate.max,
                  repeat: true,
                ))),
        Container(
          width: double.infinity,
          child: FxCard(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FxText.b1(
                    widget.name,
                    fontWeight: 700,
                  ),
                  FxText.b1(
                    "v" + widget.versi,
                    fontWeight: 500,
                  ),
                ],
              ),
              FxSpacing.height(16),
              Divider(
                color: theme.dividerColor,
                thickness: 1,
                height: 0,
              ),
              FxSpacing.height(8),
              FxText.b3(
                widget.ket,
                letterSpacing: 1.5,
              ),
              FxSpacing.height(8),
              Divider(
                color: theme.dividerColor,
                thickness: 1,
                height: 0,
              ),
              FxSpacing.height(8),
              widget.progress == ''
                  ? FxButton(
                      block: true,
                      elevation: 0,
                      borderRadiusAll: 4,
                      onPressed: widget.onpress,
                      splashColor: theme.colorScheme.onPrimary.withAlpha(80),
                      child: FxText.b2("Download Pembaruan",
                          fontWeight: 600,
                          color: theme.colorScheme.onPrimary,
                          letterSpacing: 0.5))
                  : Container(
                      height: 35,
                      margin: EdgeInsets.only(top: 6, bottom: 7),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(2)),
                        boxShadow: [
                          BoxShadow(
                            color: theme.colorScheme.primary.withAlpha(24),
                            blurRadius: 2,
                            offset: Offset(0, 1),
                          ),
                        ],
                        border: Border.all(
                            color: theme.colorScheme.primary.withAlpha(0)),
                        color: theme.colorScheme.primary.withAlpha(175),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FxText.b2(widget.progress,
                              color: theme.colorScheme.onPrimary,
                              fontWeight: 600,
                              letterSpacing: 0.5)
                        ],
                      ),
                    )
            ],
          )),
        )
      ],
    );
  }
}
