import 'package:deklarasi/theme/app_theme.dart';
import 'package:deklarasi/utils/formatcurrency.dart';
import 'package:deklarasi/widgets/sinkronisasi_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

class SinkronisasiList extends StatefulWidget {
  final String name, date, pengeluaran, site, nosurat, total, flag;
  final VoidCallback onpress;
  final BuildContext buildContext;

  const SinkronisasiList(
      {Key? key,
      required this.name,
      required this.date,
      required this.nosurat,
      required this.pengeluaran,
      required this.site,
      required this.total,
      required this.flag,
      required this.onpress,
      required this.buildContext})
      : super(key: key);

  @override
  _SinkronisasiListState createState() => _SinkronisasiListState();
}

class _SinkronisasiListState extends State<SinkronisasiList> {
  late ThemeData theme;
  late CustomTheme customTheme;

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    customTheme = AppTheme.customTheme;
    return FxCard(
      shadow: FxShadow(elevation: 8),
      child: Row(
        children: <Widget>[
          FxSpacing.width(20),
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Wrap(
                          children: <Widget>[
                            FxText.sh1(widget.name,
                                fontWeight: 700, letterSpacing: 0)
                          ],
                        ),
                      ),
                      widget.flag == "*"
                          ? FxButton.small(
                              onPressed: widget.onpress,
                              borderRadiusAll: 6,
                              buttonType: FxButtonType.text,
                              splashColor: Colors.grey,
                              child: Icon(
                                Icons.import_export,
                                color: theme.colorScheme.onBackground
                                    .withAlpha(80),
                                size: 28,
                              ))
                          : FxSpacing.width(0)
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      FxText.b1(widget.nosurat, fontWeight: 600),
                    ],
                  ),
                  widget.flag == ""
                      ? Container(
                          margin: EdgeInsets.only(top: 8),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2)),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      theme.colorScheme.primary.withAlpha(24),
                                  blurRadius: 2,
                                  offset: Offset(0, 1),
                                ),
                              ],
                              border: Border.all(
                                  color:
                                      theme.colorScheme.primary.withAlpha(0)),
                              color: Colors.redAccent),
                          child: FxText.b2(
                            "Surat belum di-DP, hubungi CS",
                            color: Colors.white,
                            fontWeight: 600,
                            fontSize: 12,
                          ),
                        )
                      : FxSpacing.height(0),
                  FxSpacing.height(16),
                  Divider(
                    color: theme.dividerColor,
                    thickness: 1,
                    height: 0,
                  ),
                  FxSpacing.height(8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.date_range_outlined,
                            color:
                                theme.colorScheme.onBackground.withAlpha(200),
                            size: 16,
                          ),
                          FxSpacing.width(4),
                          FxText.b2(
                            widget.date,
                            color:
                                theme.colorScheme.onBackground.withAlpha(200),
                            fontWeight: 500,
                            fontSize: 12,
                          ),
                        ],
                      ),
                      FxSpacing.width(16),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.event_note_outlined,
                            color:
                                theme.colorScheme.onBackground.withAlpha(200),
                            size: 16,
                          ),
                          FxSpacing.width(4),
                          FxText.b2(
                            widget.pengeluaran,
                            color:
                                theme.colorScheme.onBackground.withAlpha(200),
                            fontWeight: 500,
                            fontSize: 12,
                          ),
                        ],
                      ),
                    ],
                  ),
                  FxSpacing.height(8),
                  Divider(
                    color: theme.dividerColor,
                    thickness: 1,
                    height: 0,
                  ),
                  Wrap(
                    direction: Axis.horizontal,
                    children: <Widget>[
                      Container(
                        padding: FxSpacing.top(8),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(
                              Icons.location_on_outlined,
                              color:
                                  theme.colorScheme.onBackground.withAlpha(200),
                              size: 16,
                            ),
                            FxSpacing.width(4),
                            FxText.b2(
                              widget.site,
                              color:
                                  theme.colorScheme.onBackground.withAlpha(200),
                              fontWeight: 500,
                              fontSize: 12,
                            ),
                          ],
                        ),
                      ),
                      FxSpacing.width(16),
                      Container(
                        padding: FxSpacing.top(8),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            FxText(
                              "Total",
                              fontSize: 12,
                              fontWeight: 500,
                            ),
                            FxSpacing.width(4),
                            FxText.b2(
                              FormatCurrency.convertToIdr(
                                  widget.total == "null"
                                      ? 0
                                      : int.parse(widget.total),
                                  0),
                              color:
                                  theme.colorScheme.onBackground.withAlpha(200),
                              fontWeight: 500,
                              fontSize: 12,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
