/*
* File : Pages
* Version : 1.0.0
* */

import 'package:flutter/material.dart';

class FxSinglePage extends StatelessWidget {
  final PageViewModel? viewModel;
  final double? percentVisible;

  FxSinglePage({
    this.viewModel,
    this.percentVisible = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return new Container(
        width: double.infinity,
        color: viewModel!.color,
        child: new Opacity(
          opacity: percentVisible!,
          child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                new Transform(
                  transform: new Matrix4.translationValues(
                      0.0, 50.0 * (1.0 - percentVisible!), 0.0),
                  child: viewModel!.content
                ),
              ]),
        ));
  }
}

class PageViewModel {
  final Color color;
  final Widget content;


  PageViewModel(
    this.color,
    this.content,

  );
}
