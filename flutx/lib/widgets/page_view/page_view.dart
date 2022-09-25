import 'package:flutter/material.dart';

class FxPageView extends StatefulWidget {
  const FxPageView({Key? key}) : super(key: key);

  @override
  _FxPageViewState createState() => _FxPageViewState();
}

class _FxPageViewState extends State<FxPageView> {
  @override
  Widget build(BuildContext context) {
    return PageView();
  }
}


