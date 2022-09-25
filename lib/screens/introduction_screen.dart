/*
* File : Top Navigation widget
* Version : 1.0.0
* Description :
* */

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:deklarasi/extensions/extensions.dart';
import 'package:deklarasi/theme/app_theme.dart';

class IntroductionScreen extends StatefulWidget {
  @override
  _IntroductionScreenState createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  late ThemeData theme;
  late CustomTheme customTheme;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.theme;
    customTheme = AppTheme.customTheme;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfff1f0f6),
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(FeatherIcons.chevronLeft).autoDirection(),
        ),
        title: FxText.sh1("Cara menggunakan aplikasi ini", fontWeight: 600),
      ),
      body: DefaultTabController(
        length: 20,
        initialIndex: 0,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xfff1f0f6),
            automaticallyImplyLeading: false,
            flexibleSpace: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                /*-------------- Build Tabs here ------------------*/
                TabBar(
                  isScrollable: true,
                  tabs: [
                    Tab(child: FxText.sh1("Login", fontWeight: 600)),
                    Tab(child: FxText.sh1("Surat Jalan", fontWeight: 600)),
                    Tab(child: FxText.sh1("Form Surat Jalan", fontWeight: 600)),
                    Tab(child: FxText.sh1("Data Surat", fontWeight: 600)),
                    Tab(child: FxText.sh1("Opsi Surat", fontWeight: 600)),
                    Tab(
                        child:
                            FxText.sh1("Penjelasan 3 Opsi", fontWeight: 600)),
                    Tab(child: FxText.sh1("Pengeluaran", fontWeight: 600)),
                    Tab(
                        child:
                            FxText.sh1("Tambah Pengeluaran", fontWeight: 600)),
                    Tab(child: FxText.sh1("Form Pengeluaran", fontWeight: 600)),
                    Tab(child: FxText.sh1("Data Pengeluaran", fontWeight: 600)),
                    Tab(
                        child: FxText.sh1("Penjelasan Sinkronisasi",
                            fontWeight: 600)),
                    Tab(child: FxText.sh1("Upload #1", fontWeight: 600)),
                    Tab(child: FxText.sh1("Upload #2", fontWeight: 600)),
                    Tab(child: FxText.sh1("Upload #3", fontWeight: 600)),
                    Tab(child: FxText.sh1("Upload #4", fontWeight: 600)),
                    Tab(child: FxText.sh1("Upload #5", fontWeight: 600)),
                    Tab(child: FxText.sh1("Download #1", fontWeight: 600)),
                    Tab(child: FxText.sh1("Download #2", fontWeight: 600)),
                    Tab(child: FxText.sh1("Download #3", fontWeight: 600)),
                    Tab(child: FxText.sh1("Download #4", fontWeight: 600)),
                  ],
                )
              ],
            ),
          ),

          /*--------------- Build Tab body here -------------------*/
          body: TabBarView(
            children: <Widget>[
              getTabContent('step_1.jpg'),
              getTabContent('step_2.jpg'),
              getTabContent('step_3.jpg'),
              getTabContent('step_4.jpg'),
              getTabContent('step_5.jpg'),
              getTabContent('step_5_1.jpg'),
              getTabContent('step_6.jpg'),
              getTabContent('step_6_1.jpg'),
              getTabContent('step_7.jpg'),
              getTabContent('step_8.jpg'),
              getTabContent('step_8_1.jpg'),
              getTabContent('step_9.jpg'),
              getTabContent('step_10.jpg'),
              getTabContent('step_11.jpg'),
              getTabContent('step_12.jpg'),
              getTabContent('step_13.jpg'),
              getTabContent('step_14.jpg'),
              getTabContent('step_15.jpg'),
              getTabContent('step_16.jpg'),
              getTabContent('step_17.jpg'),
            ],
          ),
        ),
      ),
    );
  }

  Widget getTabContent(String text) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("./assets/intro/$text")),
          ),
        ));
  }
}
