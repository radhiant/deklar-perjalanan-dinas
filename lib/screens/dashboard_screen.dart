import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:deklarasi/helper/db_deklar/sql_helper.dart';
import 'package:deklarasi/helper/db_deklar/sql_helper_login.dart';
import 'package:deklarasi/helper/db_deklar/sql_helper_pengeluaran.dart';
import 'package:deklarasi/screens/introduction_screen.dart';
import 'package:deklarasi/screens/login_screen.dart';
import 'package:deklarasi/screens/update_screen.dart';
import 'package:deklarasi/theme/app_theme.dart';
import 'package:deklarasi/utils/formatDate.dart';
import 'package:deklarasi/utils/formatcurrency.dart';
import 'package:deklarasi/widgets/alert_beforedelete.dart';
import 'package:deklarasi/widgets/bottom_sheet.dart';
import 'package:deklarasi/widgets/change_theme.dart';
import 'package:deklarasi/widgets/empty_data.dart';
import 'package:deklarasi/widgets/empty_data_v2.dart';
import 'package:deklarasi/widgets/form_surat_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutx/flutx.dart';
import 'package:lottie/lottie.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../utils/server.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  late CustomTheme customTheme;
  late ThemeData theme;
  late Timer timer;

  // version and update
  String appName = '';
  String packageName = '';
  String version = '';
  String versionApp = '';
  String buildNumber = '';
  String versionUpdate = '';

  dynamic response;
  Dio dio = Dio();

  List _loadedData = [];

  // data surat
  List<Map<String, dynamic>> _surat = [];
  List<Map<String, dynamic>> _akun = [];

  bool _isLoading = true;
  // This function is used to fetch all data from the database
  void _refreshSurats() async {
    final data = await SQLHelper.getItemByKaryawan(int.parse(_akun[0]['nik']));
    setState(() {
      _surat = data;
      _isLoading = false;
    });
  }

  void _getAkun() async {
    final data = await SQLHelperLogin.getItems();
    setState(() {
      _akun = data;
      // print(_akun[0]['namalkp']);
      _refreshSurats();
    });
  }

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    _getAkun();
    _getUpdate();
    timer = Timer.periodic(Duration(seconds: 3), (Timer t) => _autorefresh());
  }

  void _autorefresh() {
    setState(() {
      _getAkun();
      _getUpdate();
      // print('auto refresh..');
    });
  }

  Future<void> _getUpdate() async {
    String myServer = Server.connectServer();
    const API_URL = "edeklarclient/api/pembaruan.php";

    HttpClient client = new HttpClient();
    client.autoUncompress = true;

    try {
      final HttpClientRequest request =
          await client.getUrl(Uri.parse(myServer + API_URL));
      request.headers.set(
          HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");
      final HttpClientResponse response =
          await request.close().timeout(const Duration(seconds: 2));

      final String content = await response.transform(utf8.decoder).join();
      final List data = json.decode(content);

      setState(() {
        _loadedData = data;
        if (_loadedData.length == 0) {
          _getVersion();
        } else {
          _getVersion();
          versionUpdate = _loadedData[0]['deklarapp_versi'];
        }
      });
    } on TimeoutException catch (_) {
      // internet timeout
    } on SocketException catch (_) {
      // internet timeout
    }
  }

  void _getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    setState(() {
      appName = packageInfo.appName;
      packageName = packageInfo.packageName;
      version = 'v' + packageInfo.version;
      versionApp = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
    });
  }

  void _showOptSheet(context, Iterable<dynamic> surat) async {
    final result = await showModalBottomSheet(
        context: context,
        builder: (BuildContext context) => BottomSheetScreen(
              data: surat,
            ));

    if (result == "update") {
      _formUpdateDialog(surat);
    } else if (result == "delete") {
      _confirmdelete(surat.elementAt(0), surat.elementAt(1));
    } else {
      _refreshSurats();
    }
  }

  void _formUpdateDialog(Iterable<dynamic> surat) async {
    final result = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => FormSuratDialog(
            title: "Form Surat",
            status: true,
            titleUpdate: "Form Ubah Surat",
            idkaryawan: int.parse(_akun[0]['nik']),
            data: surat));

    if (result == "refresh") {
      _refreshSurats();
      showSnackBarWithFloatingAction('Data Surat berhasil diubah!');
    }
  }

  void _formDialog() async {
    final result = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => FormSuratDialog(
            title: "Form Surat",
            status: false,
            titleUpdate: "",
            idkaryawan: int.parse(_akun[0]['nik']),
            data: _surat = []));

    if (result == "refresh") {
      _refreshSurats();
      showSnackBarWithFloatingAction('Data Surat berhasil ditambahkan!');
    } else {
      _refreshSurats();
    }
  }

  void _confirmdelete(int id, String title) async {
    final result = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => AlertBeforeDelete(
              title: "Yakin hapus surat " + title + "?",
            ));

    if (result == "yakin") {
      _deleteItem(id);
    } else {
      _refreshSurats();
    }
  }

  //hapus surat
  void _deleteItem(int id) async {
    await SQLHelper.deleteItem(id);
    await SQLHelperPengeluaran.deleteItemBySurat(id);
    showSnackBarWithFloatingAction('Data Surat berhasil dihapus!');
    _refreshSurats();
  }

  //logout
  void _logout() async {
    await SQLHelperLogin.deleteAll();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  void _confirmLogout() async {
    final result = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => AlertBeforeDelete(
              title: "Yakin logout ?",
            ));

    if (result == "yakin") {
      _logout();
    } else {
      _refreshSurats();
    }
  }

  void showSnackBarWithFloatingAction(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: FxText.sh2(msg, color: theme.colorScheme.onPrimary),
        backgroundColor: Colors.green,
        // elevation: 0,
        action: SnackBarAction(
          onPressed: () {},
          label: "OK",
          textColor: theme.colorScheme.onPrimary,
        ),
        behavior: SnackBarBehavior.fixed,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        elevation: 1,
        onPressed: () {
          _formDialog();
        },
        child: Icon(
          MdiIcons.plus,
          size: 26,
        ),
      ),
      body: Container(
        color: Color(0xfff1f0f6),
        child: SafeArea(
            child: ListView(
          padding: FxSpacing.x(16),
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(top: 24),
                child: Column(
                  children: [
                    Row(children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 16),
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage("./assets/other/profile.png"),
                              fit: BoxFit.fill),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 16, left: 8),
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: FxText.h6(
                            _akun.length == 0 ? "..." : _akun[0]['namalkp'],
                            fontWeight: 600,
                            letterSpacing: 0),
                      ),
                    ]),
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            FxText.h5("DASHBOARD",
                                fontWeight: 800, letterSpacing: 0),
                            Row(
                              children: <Widget>[
                                Container(
                                  child: RotatedBox(
                                    quarterTurns: 6,
                                    child: InkWell(
                                        splashColor: Colors.grey,
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      UpdateScreen()));
                                        },
                                        child: Stack(
                                          children: <Widget>[
                                            Icon(
                                              Icons.system_update,
                                              color: theme.colorScheme.primary,
                                              size: 24,
                                            ),
                                            Positioned.fill(
                                              child: Align(
                                                alignment: Alignment.bottomLeft,
                                                child: Container(
                                                  width: 12,
                                                  height: 12,
                                                  decoration: BoxDecoration(
                                                      // color: Color(0xffe4736d),
                                                      color: versionApp ==
                                                              versionUpdate
                                                          ? Color.fromARGB(
                                                              0, 0, 0, 0)
                                                          : Color(0xffe4736d),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50)),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )),
                                  ),
                                ),
                                FxSpacing.width(10),
                                InkWell(
                                  splashColor: Colors.grey,
                                  onTap: () => _confirmLogout(),
                                  child: Icon(
                                    MdiIcons.logout,
                                    color: theme.colorScheme.primary,
                                    size: 24,
                                  ),
                                ),
                              ],
                            )
                          ]),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => IntroductionScreen()));
                      },
                      child: FxCard(
                        shadow: FxShadow(
                          color: theme.colorScheme.primary.withAlpha(24),
                          elevation: 8,
                        ),
                        margin: EdgeInsets.only(top: 8),
                        color: theme.colorScheme.primary,
                        child: Container(
                          margin: EdgeInsets.only(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              FxText(
                                "Cara menggunakan aplikasi ini",
                                fontWeight: 500,
                                letterSpacing: 0,
                                color: Colors.white,
                              ),
                              Icon(
                                MdiIcons.arrowRight,
                                color: Colors.white,
                                size: 22,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
            _isLoading == true
                ? Padding(
                    padding: const EdgeInsets.only(top: 120.0),
                    child: Center(
                      child: SizedBox(
                        width: 150,
                        height: 150,
                        child: LottieBuilder.asset(
                          'assets/animation/loading.json',
                          frameRate: FrameRate.max,
                        ),
                      ),
                    ),
                  )
                : _surat.length == 0
                    ? Padding(
                        padding: const EdgeInsets.only(top: 50.0),
                        child: EmptyDataV2(
                          onpress: () {},
                        ),
                      )
                    : ListView.builder(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _surat.length,
                        itemBuilder: (BuildContext context, int index) =>
                            Container(
                                margin: FxSpacing.top(16),
                                child: InkWell(
                                  onTap: () {
                                    _showOptSheet(
                                        context, _surat[index].values.toList());
                                  },
                                  child: _ProductListWidget(
                                    name: _surat[index]['judulsurat'],
                                    date: FormatDateCustom.formatIndonesia(
                                        _surat[index]['tglsurat']),
                                    price: _surat[index]['anggaran'],
                                    pengeluaran: _surat[index]['ttlp'],
                                    jmld: _surat[index]['jmld'],
                                    buildContext: context,
                                  ),
                                )),
                      ),
            FxSpacing.height(50)
          ],
        )),
      ),
    );
  }
}

class _ProductListWidget extends StatefulWidget {
  final String name, date;
  final int price;
  final int pengeluaran;
  final int jmld;
  final BuildContext buildContext;

  const _ProductListWidget(
      {Key? key,
      required this.name,
      required this.date,
      required this.price,
      required this.pengeluaran,
      required this.jmld,
      required this.buildContext})
      : super(key: key);

  @override
  __ProductListWidgetState createState() => __ProductListWidgetState();
}

class __ProductListWidgetState extends State<_ProductListWidget> {
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
                            FxText.sh1(
                              widget.name,
                              fontWeight: 700,
                              letterSpacing: 0,
                              fontSize: 20,
                            )
                          ],
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: theme.colorScheme.onBackground.withAlpha(80),
                        size: 22,
                      )
                    ],
                  ),
                  FxSpacing.height(8),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.date_range_outlined,
                              color:
                                  theme.colorScheme.onBackground.withAlpha(200),
                              size: 20,
                            ),
                            FxSpacing.width(8),
                            FxText.b2(widget.date,
                                color: theme.colorScheme.onBackground
                                    .withAlpha(200),
                                fontWeight: 500),
                          ],
                        ),
                        FxText(
                          widget.jmld.toString() + " Pengeluaran",
                          fontSize: 14,
                          fontWeight: 500,
                        ),
                      ]),
                  FxSpacing.height(8),
                  Divider(
                    color: theme.dividerColor,
                    thickness: 1,
                    height: 0,
                  ),
                  FxSpacing.height(8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FxText(
                        "Anggaran",
                        fontSize: 14,
                        fontWeight: 600,
                      ),
                      FxText(
                        FormatCurrency.convertToIdr(widget.price, 0),
                        fontSize: 28,
                        fontWeight: 500,
                      ),
                    ],
                  ),
                  FxSpacing.height(8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FxText(
                        "Pengeluaran",
                        fontSize: 14,
                        fontWeight: 600,
                      ),
                      FxText(
                        FormatCurrency.convertToIdr(widget.pengeluaran, 0),
                        fontSize: 14,
                        fontWeight: 500,
                      ),
                    ],
                  ),
                  FxSpacing.height(8),
                  Divider(
                    color: theme.dividerColor,
                    thickness: 1,
                    height: 0,
                  ),
                  FxSpacing.height(8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FxText(
                        "Selisih",
                        fontSize: 14,
                        fontWeight: 600,
                      ),
                      FxText(
                        FormatCurrency.convertToIdr(
                            FormatCurrency.operatorPlus(
                                widget.price, widget.pengeluaran),
                            0),
                        fontSize: 14,
                        fontWeight: 500,
                        color: FormatCurrency.operatorPlus(
                                    widget.price, widget.pengeluaran) <
                                0
                            ? Colors.redAccent
                            : theme.colorScheme.onBackground,
                      ),
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
