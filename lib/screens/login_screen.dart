/*
* File : Login
* Version : 1.0.0
* */

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:deklarasi/helper/db_deklar/sql_helper_login.dart';
import 'package:deklarasi/screens/dashboard_screen.dart';
import 'package:deklarasi/screens/introduction_screen.dart';
import 'package:deklarasi/theme/app_theme.dart';
import 'package:deklarasi/utils/server.dart';
import 'package:deklarasi/widgets/alert_validation.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:lottie/lottie.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool? _passwordVisible = true;
  late CustomTheme customTheme;
  late ThemeData theme;

  bool _isLoading = true;

  List _loadedLogin = [];
  List<Map<String, dynamic>> _akun = [];

  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _prosesLogin() {
    if (_userController.text == '') {
      _showAlert('Oops!', 'Username masih belum di isi!');
    } else if (_passwordController.text == '') {
      _showAlert('Oops!', 'Password masih belum di isi!');
    } else {
      setState(() {
        _isLoading = true;
      });
      _fetchData(_userController.text, _passwordController.text);
    }
  }

  void _showAlert(String title, String desc) {
    showDialog(
        context: context,
        builder: (BuildContext context) =>
            AlertValidation(title: title, desc: desc));
  }

  void _getAkun() async {
    final data = await SQLHelperLogin.getItems();
    setState(() {
      _akun = data;
      if (_akun.length > 0) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => DashboardScreen()));
        print("Akun login:" + _akun.length.toString());
      } else {
        print("Akun login:" + _akun.length.toString());
        _isLoading = false;
      }
    });
  }

  Future<void> _addAkun(
      String nik, String namalkp, String nama, String unit) async {
    await SQLHelperLogin.createItem(nik, namalkp, nama, unit);
    _getAkun();
  }

  Future<void> _fetchData(String name, String accno) async {
    String get = 'name=' + name + '&accno=' + accno;
    String myServer = Server.connectServer();
    const API_URL = "edeklarclient/api/login.php?";

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
        _loadedLogin = data;
        if (_loadedLogin.length == 0) {
          print("Jumlah data: " + _loadedLogin.length.toString());
          _showAlert('Oops!', 'user & password salah.');
          _isLoading = false;
        } else {
          print("Jumlah data: " + _loadedLogin.length.toString());
          _addAkun(_loadedLogin[0]['nik'], _loadedLogin[0]['Namalkp'],
              _loadedLogin[0]['nama'], _loadedLogin[0]['unit']);
        }
      });
    } on TimeoutException catch (_) {
      _showAlert(
          'Oops!', 'Ada masalah di sambungan internet, Silahkan coba lagi!');
      setState(() {
        _isLoading = false;
      });
    } on SocketException catch (_) {
      _showAlert(
          'Oops!', 'Ada masalah di sambungan internet, Silahkan coba lagi!');
      setState(() {
        _isLoading = false;
      });
    }
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
        body: Stack(
      children: <Widget>[
        ClipPath(
            clipper: _MyCustomClipper(context),
            child: Container(
              alignment: Alignment.center,
              color: Color(0xfff1f0f6),
            )),
        Positioned(
          left: 30,
          right: 30,
          top: MediaQuery.of(context).size.height * 0.2,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              FxContainer.bordered(
                padding: EdgeInsets.only(top: 16, bottom: 16),
                color: theme.scaffoldBackgroundColor,
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Image.asset(
                        './assets/brand/bku.png',
                        width: 100,
                        height: 100,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 24, top: 8),
                      child: FxText.h6("DEKLARASI", fontWeight: 600),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: _userController,
                            style: FxTextStyle.b1(
                                letterSpacing: 0.1,
                                color: theme.colorScheme.onBackground,
                                fontWeight: 500),
                            decoration: InputDecoration(
                              hintText: "Username",
                              hintStyle: FxTextStyle.sh2(
                                  letterSpacing: 0.1,
                                  color: theme.colorScheme.onBackground,
                                  fontWeight: 500),
                              prefixIcon: Icon(MdiIcons.account),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 16),
                            child: TextFormField(
                              controller: _passwordController,
                              style: FxTextStyle.b1(
                                  letterSpacing: 0.1,
                                  color: theme.colorScheme.onBackground,
                                  fontWeight: 500),
                              decoration: InputDecoration(
                                hintText: "Password",
                                hintStyle: FxTextStyle.sh2(
                                    letterSpacing: 0.1,
                                    color: theme.colorScheme.onBackground,
                                    fontWeight: 500),
                                prefixIcon: Icon(MdiIcons.lockOutline),
                                suffixIcon: IconButton(
                                  icon: Icon(_passwordVisible!
                                      ? MdiIcons.eyeOutline
                                      : MdiIcons.eyeOffOutline),
                                  onPressed: () {
                                    setState(() {
                                      _passwordVisible = !_passwordVisible!;
                                    });
                                  },
                                ),
                              ),
                              obscureText: _passwordVisible!,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 16),
                            child: _isLoading == true
                                ? Container(
                                    padding: FxSpacing.y(0),
                                    child: SizedBox(
                                      width: 100,
                                      height: 100,
                                      child: LottieBuilder.asset(
                                        'assets/animation/loading.json',
                                        frameRate: FrameRate.max,
                                      ),
                                    ))
                                : FxButton.block(
                                    elevation: 0,
                                    borderRadiusAll: 4,
                                    padding: FxSpacing.y(12),
                                    onPressed: () {
                                      _prosesLogin();
                                    },
                                    child: FxText.button("LOGIN",
                                        fontWeight: 600,
                                        color: theme.colorScheme.onPrimary,
                                        letterSpacing: 0.5)),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => IntroductionScreen()));
                },
                child: Container(
                  margin: EdgeInsets.only(top: 16),
                  child: Center(
                    child: RichText(
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: "Cara menggunakan aplikasi ini? ",
                            style: FxTextStyle.b2(fontWeight: 500)),
                        TextSpan(
                            text: " Klik disini",
                            style: FxTextStyle.b2(
                                fontWeight: 600,
                                color: theme.colorScheme.primary)),
                      ]),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    ));
  }
}

class _MyCustomClipper extends CustomClipper<Path> {
  final BuildContext _context;

  _MyCustomClipper(this._context);

  @override
  Path getClip(Size size) {
    final path = Path();
    Size size = MediaQuery.of(_context).size;
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.3);
    path.lineTo(0, size.height * 0.6);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
}
