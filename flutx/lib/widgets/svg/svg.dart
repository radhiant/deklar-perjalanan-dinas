
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class FxSvg extends StatefulWidget {
  final String image;
  final Color? color;
  final double? size;


  const FxSvg(this.image, {this.color, this.size = 24});

  @override
  _FxTwoToneIconState createState() => _FxTwoToneIconState();
}

class _FxTwoToneIconState extends State<FxSvg> {
  String? iconDataString;
  String? image;

  @override
  void initState() {
    super.initState();
    getIconDataString();
  }

  @override
  Widget build(BuildContext context) {

    fetchCacheData();

    if(image!=null ){
      if(!(image==widget.image))
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
    String data = await rootBundle.loadString(widget.image);

    setState(() {
      iconDataString = data;
      image = widget.image;
    });

    FxSvgCache.cache[widget.image] = data;
  }

  void fetchCacheData() {
    iconDataString = FxSvgCache.cache[widget.image];
  }



}


class FxSvgCache{

  static Map<String,String> cache = {};

}
