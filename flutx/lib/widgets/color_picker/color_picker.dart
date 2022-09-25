import 'package:flutter/material.dart';

typedef void OnChangeColor(Color color);

class FxColorPicker extends StatelessWidget {
  final List<Color> colors;
  final Color? selectedColor;
  final OnChangeColor onChangeColor;
  final int crossAxisCount;

  FxColorPicker({
    Key? key,
    required this.colors,
    this.selectedColor,
    required this.onChangeColor,
    required this.crossAxisCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: colors.length,
        itemBuilder: (BuildContext context, int index) {
          Color newColor = colors[index];
          bool selected = (colors.contains(selectedColor)) ? ( newColor == selectedColor) : (index==0);
          return InkWell(
            onTap: () {
              onChangeColor(newColor);
            },
            child: Container(
              height: 16,
              child: selected
                  ? Icon(
                      Icons.check,
                      size: 20,
                      color: Colors.white,
                    )
                  : Container(),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: newColor,
              ),
            ),
          );
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1,
        ),
      ),
    );
  }
}
