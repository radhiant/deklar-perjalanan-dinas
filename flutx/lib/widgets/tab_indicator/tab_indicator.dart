import 'package:flutter/material.dart';

enum FxTabIndicatorStyle {
  circle,
  rectangle
}

class FxTabIndicator extends Decoration {
  final double indicatorHeight, width, yOffset, radius;
  final Color indicatorColor;
  final FxTabIndicatorStyle indicatorStyle;

  const FxTabIndicator({
    this.indicatorHeight = 2,
    required this.indicatorColor,
    this.indicatorStyle = FxTabIndicatorStyle.circle,
    this.width = 20,
    this.yOffset = 28,
    this.radius = 4
  });

  @override
  _FxTabIndicatorPainter createBoxPainter([VoidCallback? onChanged]) {
    return _FxTabIndicatorPainter(this, onChanged);
  }
}

class _FxTabIndicatorPainter extends BoxPainter {
  final FxTabIndicator decoration;

  _FxTabIndicatorPainter(this.decoration, VoidCallback? onChanged) : super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration.size != null);

    if (decoration.indicatorStyle == FxTabIndicatorStyle.circle) {
      final Paint paint = Paint()
        ..color = decoration.indicatorColor
        ..style = PaintingStyle.fill;
      final Offset circleOffset = offset + Offset(configuration.size!.width / 2 - (decoration.radius/2), decoration.yOffset);
      canvas.drawCircle(circleOffset, decoration.radius, paint);

    }else if(decoration.indicatorStyle == FxTabIndicatorStyle.rectangle){
      Rect rect = Offset(
        offset.dx + configuration.size!.width / 2 - (decoration.width/2),
        decoration.yOffset,
      ) &
      Size(decoration.width, decoration.indicatorHeight);

      RRect radiusRectangle = RRect.fromRectAndRadius(rect, Radius.circular(decoration.radius));
      final Paint paint = Paint()
        ..color = decoration.indicatorColor
        ..style = PaintingStyle.fill;
      canvas.drawRRect(radiusRectangle, paint,);
    }
  }
}