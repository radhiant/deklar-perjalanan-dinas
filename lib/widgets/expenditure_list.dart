import 'package:deklarasi/theme/app_theme.dart';
import 'package:deklarasi/utils/formatcurrency.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ExpenditureList extends StatefulWidget {
  final String name, date, category, nota;
  final dynamic price;
  final VoidCallback ontap;
  final BuildContext buildContext;

  const ExpenditureList(
      {Key? key,
      required this.name,
      required this.date,
      required this.price,
      required this.category,
      required this.nota,
      required this.ontap,
      required this.buildContext})
      : super(key: key);

  @override
  _ExpenditureListState createState() => _ExpenditureListState();
}

class _ExpenditureListState extends State<ExpenditureList> {
  late ThemeData theme;
  late CustomTheme customTheme;

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    customTheme = AppTheme.customTheme;
    return FxCard(
      shadow: FxShadow(
        color: theme.colorScheme.primary.withAlpha(24),
        elevation: 8,
      ),
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
                      FxButton.medium(
                          onPressed: widget.ontap,
                          buttonType: FxButtonType.text,
                          splashColor: Colors.grey,
                          child: Icon(
                            MdiIcons.pencilOutline,
                            color: theme.colorScheme.onBackground.withAlpha(80),
                            size: 22,
                          ))
                    ],
                  ),
                  FxSpacing.height(8),
                  Row(
                    children: <Widget>[
                      FxText.b1(FormatCurrency.convertToIdr(widget.price, 0),
                          fontWeight: 500),
                    ],
                  ),
                  FxSpacing.height(8),
                  Divider(
                    color: theme.dividerColor,
                    thickness: 1,
                    height: 0,
                  ),
                  FxSpacing.height(8),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.date_range_outlined,
                              color:
                                  theme.colorScheme.onBackground.withAlpha(200),
                              size: 12,
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
                        FxSpacing.width(14),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.category_outlined,
                              color:
                                  theme.colorScheme.onBackground.withAlpha(200),
                              size: 12,
                            ),
                            FxSpacing.width(4),
                            FxText.b2(
                              widget.category,
                              color:
                                  theme.colorScheme.onBackground.withAlpha(200),
                              fontWeight: 500,
                              fontSize: 12,
                            ),
                          ],
                        ),
                        FxSpacing.width(14),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.note_alt_outlined,
                              color:
                                  theme.colorScheme.onBackground.withAlpha(200),
                              size: 12,
                            ),
                            FxSpacing.width(4),
                            FxText.b2(
                              widget.nota,
                              color:
                                  theme.colorScheme.onBackground.withAlpha(200),
                              fontWeight: 500,
                              fontSize: 12,
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
