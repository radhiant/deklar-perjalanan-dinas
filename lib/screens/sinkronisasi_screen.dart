/*
* File : LMS Dashboard
* Version : 1.0.0
* */

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:deklarasi/helper/db_deklar/sql_helper_pengeluaran.dart';
import 'package:deklarasi/theme/app_theme.dart';
import 'package:deklarasi/utils/formatDate.dart';
import 'package:deklarasi/widgets/alert_loading.dart';
import 'package:deklarasi/widgets/alert_validation.dart';
import 'package:deklarasi/widgets/change_theme.dart';
import 'package:deklarasi/widgets/empty_data.dart';
import 'package:deklarasi/widgets/empty_data_v2.dart';
import 'package:deklarasi/widgets/sinkronisasi_bottomsheet.dart';
import 'package:deklarasi/widgets/sinkronisasi_dialog.dart';
import 'package:deklarasi/widgets/sinkronisasi_list.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:lottie/lottie.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:deklarasi/helper/db_deklar/sql_helper_login.dart';
import 'package:dio/dio.dart';

import '../utils/server.dart';
import '../widgets/nointernet.dart';

class SinkronisasiScreen extends StatefulWidget {
  final Iterable<dynamic> data;

  const SinkronisasiScreen({
    required this.data,
  });

  @override
  _SinkronisasiScreenState createState() => _SinkronisasiScreenState();
}

class _SinkronisasiScreenState extends State<SinkronisasiScreen> {
  late CustomTheme customTheme;
  late ThemeData theme;

  List<Map<String, dynamic>> _akun = [];
  List _loadedData = [];
  bool _isLoading = true;
  bool _noInternet = true;

  dynamic response;
  Dio dio = Dio();

  Future<void> _fetchData(String name) async {
    String get = 'nama=' + name;
    String myServer = Server.connectServer();
    const API_URL = "edeklarclient/api/fetch.proses.php?";

    HttpClient client = new HttpClient();
    client.autoUncompress = true;

    try {
      final HttpClientRequest request =
          await client.getUrl(Uri.parse(myServer + API_URL + get));
      request.headers.set(
          HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");
      final HttpClientResponse response =
          await request.close().timeout(const Duration(seconds: 2));

      final String content = await response.transform(utf8.decoder).join();
      final List data = json.decode(content);

      setState(() {
        _loadedData = data;
        if (_loadedData.length == 0) {
          _isLoading = false;
          _noInternet = false;
          print("Jumlah data: " + _loadedData.length.toString());
        } else {
          _isLoading = false;
          _noInternet = false;
          print("Jumlah data: " + _loadedData.length.toString());
        }
      });
    } on TimeoutException catch (_) {
      setState(() {
        _isLoading = false;
        _noInternet = true;
      });
    } on SocketException catch (_) {
      setState(() {
        _isLoading = false;
        _noInternet = true;
      });
    }
  }

  void _getAkun() async {
    final data = await SQLHelperLogin.getItems();
    setState(() {
      _akun = data;
      print(_akun[0]['nama']);
      _fetchData(_akun[0]['nama']);
    });
  }

  void _showOptSheet(context, String nosurat) async {
    final result = await showModalBottomSheet(
        context: context,
        builder: (BuildContext context) => SinkronisasiBottomsheet(
              data: nosurat,
            ));

    if (result == "upload") {
      _showAlert("Upload Data?", "Data di server akan tertimpa data hp!",
          "upload", nosurat);
    } else if (result == "download") {
      _showAlert("Download Data?", "Data di hp akan tertimpa data server!",
          "download", nosurat);
    } else {
      _getAkun();
    }
  }

  void _postData(String nost) async {
    final data =
        await SQLHelperPengeluaran.getItemBySurat(widget.data.elementAt(0));
    String server = Server.connectServer();
    String _baseUrl = server + "edeklarclient/api/upload.proses.php";
    var options = Options(
      contentType: "application/x-www-form-urlencoded; charset=UTF-8",
      followRedirects: false,
    );

    if (data.length == 0) {
      Navigator.pop(context);
      _showAlert2("Oops!", "Data pengeluaran anda masih kosong!");
    } else {
      final respone = await dio.post(
        _baseUrl,
        data: {"nost": nost, "data": data},
        options: options,
      );
      print(respone);
      _getAkun();
      Navigator.pop(context);
      showSnackBarWithFloatingAction('Data berhasil di upload !');
    }
  }

  Future<void> _downloadData(String nosurat) async {
    String get = 'nost=' + nosurat;
    String server = Server.connectServer();
    const API_URL = "edeklarclient/api/getAnggaran.php?";

    HttpClient client = new HttpClient();
    client.autoUncompress = true;

    final HttpClientRequest request =
        await client.getUrl(Uri.parse(server + API_URL + get));
    request.headers
        .set(HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");
    final HttpClientResponse response = await request.close();

    final String content = await response.transform(utf8.decoder).join();
    final List data = json.decode(content);

    setState(() {
      if (data.length == 0) {
        Navigator.pop(context);
        _showAlert2("Oops!", "tidak ada data pengeluaran!");
      } else {
        _prosesDownload(widget.data, data);
      }
    });
  }

  Future<void> _prosesDownload(Iterable<dynamic> surat, List data) async {
    await SQLHelperPengeluaran.deleteItemBySurat(surat.elementAt(0));
    await SQLHelperPengeluaran.multipleCreate(surat.elementAt(0), data);
    Navigator.pop(context);
    Navigator.of(context).pop("download");
  }

  void _showAlert(String title, String opt, String type, String nosurat) async {
    final result = await showDialog(
        context: context,
        builder: (BuildContext context) => SinkronisasiDialog(
              title: title,
              desc: opt,
            ));

    if (result == "konfirmasi") {
      if (type == "download") {
        _showloding();
        _downloadData(nosurat);
      } else if (type == "upload") {
        _showloding();
        _postData(nosurat);
      } else {
        _getAkun();
      }
    } else if (result == "batal") {
      _getAkun();
    } else {
      _getAkun();
    }
  }

  void _showloding() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => AlertLoading());
  }

  void _showAlert2(String title, String desc) {
    showDialog(
        context: context,
        builder: (BuildContext context) =>
            AlertValidation(title: title, desc: desc));
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
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    _getAkun();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xfff1f0f6),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            MdiIcons.chevronLeft,
          ),
        ),
        title: FxText.sh1("Sinkronisasi", fontWeight: 600),
        // actions: <Widget>[ChangeTheme()],
      ),
      body: _isLoading
          ? Container(
              color: Color(0xfff1f0f6),
              child: Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: Center(
                  child: SizedBox(
                    width: 250,
                    height: 250,
                    child: LottieBuilder.asset(
                      'assets/animation/loading.json',
                      frameRate: FrameRate.max,
                    ),
                  ),
                ),
              ),
            )
          : _noInternet
              ? Container(
                  color: Color(0xfff1f0f6),
                  padding: const EdgeInsets.only(top: 50, bottom: 16),
                  child: NoInternet(
                      desc: "Masalah pada sambungan internet!",
                      onpress: () {
                        setState(() {
                          _isLoading = true;
                          _getAkun();
                        });
                      }),
                )
              : _loadedData.length == 0
                  ? Container(
                      color: Color(0xfff1f0f6),
                      child: EmptyDataV2(
                        onpress: () {},
                      ),
                    )
                  : RefreshIndicator(
                      backgroundColor: Color(0xfff1f0f6),
                      onRefresh: () async {
                        setState(() {
                          _isLoading = true;
                          _getAkun();
                        });
                      },
                      child: Container(
                        color: Color(0xfff1f0f6),
                        child: ListView.builder(
                            // physics: ScrollPhysics(),
                            // shrinkWrap: true,
                            itemCount: _loadedData.length,
                            itemBuilder: (BuildContext context, int index) =>
                                Container(
                                  padding: EdgeInsets.only(
                                      left: 20, right: 20, top: 16),
                                  child: SinkronisasiList(
                                    onpress: () {
                                      _showOptSheet(
                                          context, _loadedData[index]['no_st']);
                                    },
                                    name: _loadedData[index]['tujuan'],
                                    buildContext: context,
                                    date: FormatDateCustom.formatIndonesia(
                                        _loadedData[index]['tgl']),
                                    nosurat: _loadedData[index]['no_st'],
                                    pengeluaran: _loadedData[index]['item'] +
                                        " Pengeluaran",
                                    flag: _loadedData[index]['flag'],
                                    site: _loadedData[index]['namaremote']
                                        .toString(),
                                    total: _loadedData[index]['pengeluaran']
                                        .toString(),
                                  ),
                                )),
                      )),
    );
  }
}
