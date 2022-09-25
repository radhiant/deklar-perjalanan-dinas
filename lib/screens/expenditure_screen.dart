/*
* File : LMS Dashboard
* Version : 1.0.0
* */

import 'package:deklarasi/helper/db_deklar/sql_helper.dart';
import 'package:deklarasi/helper/db_deklar/sql_helper_pengeluaran.dart';
import 'package:deklarasi/screens/sinkronisasi_screen.dart';
import 'package:deklarasi/theme/app_theme.dart';
import 'package:deklarasi/utils/formatDate.dart';
import 'package:deklarasi/widgets/alert_beforedelete.dart';
import 'package:deklarasi/widgets/change_theme.dart';
import 'package:deklarasi/widgets/empty_data.dart';
import 'package:deklarasi/widgets/empty_data_v2.dart';
import 'package:deklarasi/widgets/expenditure_bottomsheet.dart';
import 'package:deklarasi/widgets/expenditure_dashboard.dart';
import 'package:deklarasi/widgets/expenditure_list.dart';
import 'package:deklarasi/widgets/form_expenditure.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:lottie/lottie.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ExpenditureScreen extends StatefulWidget {
  final Iterable<dynamic> data;

  const ExpenditureScreen({
    required this.data,
  });

  @override
  _ExpenditureScreenState createState() => _ExpenditureScreenState();
}

class _ExpenditureScreenState extends State<ExpenditureScreen> {
  late CustomTheme customTheme;
  late ThemeData theme;

  // data surat
  List<Map<String, dynamic>> _pengeluaran = [];
  bool _isLoading = true;
  int _totalPengeluan = 0;
  int _selisih = 0;

  // Get Data
  void _refreshPengeluaran() async {
    final data =
        await SQLHelperPengeluaran.getItemBySurat(widget.data.elementAt(0));
    final sumData =
        await SQLHelperPengeluaran.getItemSum(widget.data.elementAt(0));
    setState(() {
      _pengeluaran = data;
      _isLoading = false;
      _totalPengeluan = sumData == null ? 0 : sumData;
      _selisih = (widget.data.elementAt(2)) - (sumData == null ? 0 : sumData);
    });

    _updateSurat(widget.data.elementAt(0), sumData == null ? 0 : sumData,
        _pengeluaran.length);
  }

  void _updateSurat(int id, int ttlp, int jmld) async {
    await SQLHelper.updateTotalPengeluaran(id, ttlp, jmld);
  }

  void _formDialog() async {
    final result = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => FormExpenditure(
              title: "Tambah Pengeluaran",
              status: false,
              titleUpdate: "",
              data: _pengeluaran = [],
              idsurat: widget.data.elementAt(0),
            ));

    if (result == "refresh") {
      _refreshPengeluaran();
      showSnackBarWithFloatingAction('Pengeluaran berhasil ditambahkan!');
    } else {
      _refreshPengeluaran();
    }
  }

  void _formUpdateDialog(Iterable<dynamic> pengeluaran) async {
    final result = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => FormExpenditure(
            title: "Form Pengeluaran",
            status: true,
            idsurat: pengeluaran.elementAt(1),
            titleUpdate: "Form Ubah Pengeluaran",
            data: pengeluaran));

    if (result == "refresh") {
      _refreshPengeluaran();
      showSnackBarWithFloatingAction('Pengeluaran berhasil diubah!');
    } else {
      _refreshPengeluaran();
    }
  }

  void _confirmdelete(int id) async {
    final result = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => AlertBeforeDelete(
              title: "Yakin hapus?",
            ));

    if (result == "yakin") {
      _deleteItem(id);
    } else {
      _refreshPengeluaran();
    }
  }

  //hapus pengeluaran
  void _deleteItem(int id) async {
    await SQLHelperPengeluaran.deleteItem(id);
    showSnackBarWithFloatingAction('Pengeluaran berhasil dihapus!');
    _refreshPengeluaran();
  }

  // to sync page
  void _toSinkronisasi() async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SinkronisasiScreen(
                  data: widget.data,
                )));

    if (result == "download") {
      _refreshPengeluaran();
      showSnackBarWithFloatingAction('Data berhasil didownload !');
    } else if (result == "upload") {
      _refreshPengeluaran();
      showSnackBarWithFloatingAction('Data berhasil di upload !');
    } else {
      _refreshPengeluaran();
    }
  }

  void _showOptSheet(context, Iterable<dynamic> data) async {
    final result = await showModalBottomSheet(
        context: context,
        builder: (BuildContext context) => ExpenditureBottomsheet(
              data: data,
            ));

    if (result == "update") {
      _formUpdateDialog(data);
    } else if (result == "delete") {
      _confirmdelete(data.elementAt(0));
    } else {
      _refreshPengeluaran();
    }
  }

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;

    _refreshPengeluaran();
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
          title: FxText.sh1(widget.data.elementAt(1), fontWeight: 600),
          // actions: <Widget>[ChangeTheme()],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
          child: ListView(
            children: <Widget>[
              Container(
                child: GridView.count(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    crossAxisCount: 2,
                    padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                    mainAxisSpacing: 20,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 20,
                    children: <Widget>[
                      ExpenditureDashboard(
                        subject: 'Anggaran',
                        backgroundColor: theme.colorScheme.primary,
                        value: widget.data.elementAt(2),
                      ),
                      ExpenditureDashboard(
                          subject: 'Total pengeluaran',
                          backgroundColor: Colors.orange,
                          value: _totalPengeluan),
                      ExpenditureDashboard(
                          subject: 'Selisih',
                          backgroundColor:
                              _selisih < 0 ? Colors.red : Colors.green,
                          value: _selisih),
                      ExpenditureDashboard(
                        subject: 'Jumlah data',
                        backgroundColor: Colors.blueGrey,
                        isNum: true,
                        value: _pengeluaran.length,
                      ),
                    ]),
              ),
              Container(
                padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FxText.caption("PENGELUARAN",
                        fontWeight: 600, letterSpacing: 0.3),
                    FxButton.medium(
                        onPressed: () {
                          _toSinkronisasi();
                        },
                        buttonType: FxButtonType.text,
                        splashColor: Colors.grey,
                        backgroundColor: theme.colorScheme.primary,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(
                              Icons.sync,
                              color: Colors.grey,
                              size: 22,
                            ),
                            FxSpacing.width(8),
                            FxText.b3("Sinkronisasi"),
                          ],
                        ))
                  ],
                ),
              ),
              _isLoading
                  ? Padding(
                      padding: const EdgeInsets.only(top: 24.0),
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
                  : _pengeluaran.length == 0
                      ? EmptyDataV2(
                          onpress: () {},
                        )
                      : ListView.builder(
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _pengeluaran.length,
                          itemBuilder: (BuildContext context, int index) =>
                              Container(
                                  padding: EdgeInsets.only(
                                      left: 20, right: 20, top: 16),
                                  child: ExpenditureList(
                                    name: _pengeluaran[index]['deskripsi'],
                                    buildContext: context,
                                    date: FormatDateCustom.formatIndonesia(
                                        _pengeluaran[index]['tglpengeluaran']),
                                    price: _pengeluaran[index]['jumlah'],
                                    category: _pengeluaran[index]['kategori'],
                                    nota: _pengeluaran[index]['nota'],
                                    ontap: () {
                                      _showOptSheet(context,
                                          _pengeluaran[index].values.toList());
                                    },
                                  ))),
              FxSpacing.height(32)
            ],
          ),
        ));
  }
}
