// Copyright 2021 The FlutX Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// [FxTwoToneIcon] - provides two tone Icons.

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_svg/flutter_svg.dart';
import 'two_tone_icon_data.dart';

export 'two_tone_icon_data.dart';
export 'two_tone_mdi_icons.dart';

class FxTwoToneIcon extends StatefulWidget {
  final FxTwoToneIconData iconData;
  final Color? color;
  final double? size;


  const FxTwoToneIcon(this.iconData, {this.color, this.size = 24});

  @override
  _FxTwoToneIconState createState() => _FxTwoToneIconState();
}

class _FxTwoToneIconState extends State<FxTwoToneIcon> {
  String? iconDataString;
  FxTwoToneIconData? iconData;

  @override
  void initState() {
    super.initState();
    getIconDataString();
  }

  @override
  Widget build(BuildContext context) {

    fetchCacheData();

    if(iconData!=null ){
      if(!(iconData==widget.iconData))
        getIconDataString();
    }



    return iconDataString == null
        ? Container()
        : SvgPicture.string(
            iconDataString!,
            color: widget.color,
            width: widget.size,
            height: widget.size,
          );
  }

  getIconDataString() async {
    String data = await rootBundle.loadString(widget.iconData.path);

    setState(() {
      iconDataString = data;
      iconData = widget.iconData;
    });

    FxTwoToneIconDataCache.cache[widget.iconData] = data;
  }

  void fetchCacheData() {
    iconDataString = FxTwoToneIconDataCache.cache[widget.iconData];
  }



}
