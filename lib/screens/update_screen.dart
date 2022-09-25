import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:deklarasi/widgets/empty_data_v2.dart';
import 'package:deklarasi/widgets/nointernet.dart';
import 'package:deklarasi/widgets/update_list.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:lottie/lottie.dart';
import 'package:open_file/open_file.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import '../theme/app_theme.dart';
import '../utils/server.dart';
import '../widgets/alert_validation.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({Key? key}) : super(key: key);

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen>
    with SingleTickerProviderStateMixin {
  late ThemeData theme;
  String appName = '';
  String packageName = '';
  String version = '';
  String versionApp = '';
  String buildNumber = '';
  String versionUpdate = '';

  dynamic response;
  Dio dio = Dio();

  List _loadedData = [];
  bool _isLoading = true;
  bool _noInternet = false;

  String downloadMessage = '';

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
          _isLoading = false;
          _noInternet = false;
          _getVersion();
          print(_loadedData);
        } else {
          _isLoading = false;
          _noInternet = false;
          _getVersion();
          versionUpdate = _loadedData[0]['deklarapp_versi'];
          print(_loadedData[0]['deklarapp_versi']);
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

  void _download(String file, String name) async {
    setState(() {
      downloadMessage = 'Memuat...';
    });
    var dir = await getExternalStorageDirectory();
    await dir?.delete(recursive: true);
    try {
      dio.download(file, '${dir?.path}/deklar_v' + name + '.apk',
          onReceiveProgress: (int actualbytes, int totalbytes) {
        var presentage = actualbytes / totalbytes * 100;
        if (presentage < 100) {
          setState(() {
            downloadMessage = 'Downloading... ${presentage.floor()}%';
          });
        } else {
          setState(() {
            downloadMessage = '';
          });
          OpenFile.open('${dir?.path}/deklar_v' + name + '.apk');
        }
      });
    } on DioError catch (ex) {
      if (ex.type == DioErrorType.connectTimeout) {
        _showAlert(
            'Oops!', 'Ada masalah di sambungan internet, Silahkan coba lagi!');
        setState(() {
          downloadMessage = '';
        });
      }
      _showAlert(
          'Oops!', 'Ada masalah di sambungan internet, Silahkan coba lagi!');
      setState(() {
        downloadMessage = '';
      });
    }
  }

  void _showAlert(String title, String desc) {
    showDialog(
        context: context,
        builder: (BuildContext context) =>
            AlertValidation(title: title, desc: desc));
  }

  @override
  void initState() {
    super.initState();
    _getUpdate();
    theme = AppTheme.theme;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0, backgroundColor: Color(0xfff1f0f6)),
      body: Container(
        color: Color(0xfff1f0f6),
        child: RefreshIndicator(
            backgroundColor: Colors.white,
            onRefresh: () async {
              setState(() {
                _isLoading = true;
                _getUpdate();
              });
            },
            child: SafeArea(
              child: ListView(
                padding: FxSpacing.x(16),
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(top: 16),
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                FxText.h5("PEMBARUAN",
                                    fontWeight: 800, letterSpacing: 0),
                                FxText.h6(
                                  version,
                                  fontWeight: 600,
                                  letterSpacing: 0,
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ]),
                        ),
                      ])),
                  _isLoading
                      ? Container(
                          color: Color(0xfff1f0f6),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 50.0),
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
                          ? Padding(
                              padding:
                                  const EdgeInsets.only(top: 32, bottom: 16),
                              child: NoInternet(
                                  desc: "Masalah pada sambungan internet!",
                                  onpress: () {
                                    setState(() {
                                      _isLoading = true;
                                      _getUpdate();
                                    });
                                  }),
                            )
                          : _loadedData.length == 0
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      top: 32, bottom: 16),
                                  child: EmptyDataV2(
                                      desc: "Tidak ada pembaruan",
                                      onpress: () {}),
                                )
                              : versionApp == versionUpdate
                                  ? Padding(
                                      padding: const EdgeInsets.only(
                                          top: 32, bottom: 16),
                                      child: EmptyDataV2(
                                          desc: "Tidak ada pembaruan",
                                          onpress: () {}),
                                    )
                                  : Container(
                                      color: Color(0xfff1f0f6),
                                      child: ListView.builder(
                                          physics: ScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: _loadedData.length,
                                          itemBuilder: (BuildContext context,
                                                  int index) =>
                                              UpdateList(
                                                name: _loadedData[index]
                                                    ['deklarapp_nama'],
                                                versi: _loadedData[index]
                                                    ['deklarapp_versi'],
                                                ket: _loadedData[index]
                                                    ['deklarapp_ket'],
                                                progress: downloadMessage,
                                                onpress: () {
                                                  _download(
                                                      _loadedData[index]
                                                          ['deklarapp_link'],
                                                      _loadedData[index]
                                                          ['deklarapp_versi']);
                                                },
                                              )),
                                    )
                ],
              ),
            )),
      ),
    );
  }
}
