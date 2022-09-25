import 'package:deklarasi/helper/db_deklar/sql_helper_pengeluaran.dart';
import 'package:deklarasi/theme/app_theme.dart';
import 'package:deklarasi/utils/formatDate.dart';
import 'package:deklarasi/utils/formatcurrency.dart';
import 'package:deklarasi/utils/setOpt.dart';
import 'package:deklarasi/widgets/alert_validation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class FormExpenditure extends StatefulWidget {
  final String title, titleUpdate;
  final int idsurat;
  final bool status;
  final Iterable<dynamic> data;

  FormExpenditure(
      {required this.title,
      this.status = false,
      this.titleUpdate = "",
      required this.idsurat,
      required this.data});

  @override
  State<FormExpenditure> createState() => _FormExpenditureState();
}

class _FormExpenditureState extends State<FormExpenditure> {
  DateTime? selectedDate;
  int? _radioValue = 1;
  int? _radioValue2 = 1;

  late ThemeData theme;
  String txtDate = "Pilih Tanggal";

  int _maxLength = 1;

  final TextEditingController _deskripsiController = TextEditingController();
  final TextEditingController _jumlahController = TextEditingController();
  String _kategoriController = 'Transport';
  String _notaController = 'Dengan Nota';
  String _dateController = '';

  Future<void> _addPengeluaran() async {
    await SQLHelperPengeluaran.createItem(
        widget.idsurat,
        _deskripsiController.text,
        int.parse(FormatCurrency.removeSC(_jumlahController.text)),
        _dateController,
        _kategoriController,
        _notaController);
    Navigator.of(context).pop('refresh');
  }

  Future<void> _updatePengeluaran(int id) async {
    await SQLHelperPengeluaran.updateItem(
        id,
        _deskripsiController.text,
        int.parse(FormatCurrency.removeSC(_jumlahController.text)),
        _dateController,
        _kategoriController,
        _notaController);
    Navigator.of(context).pop('refresh');
  }

  void validateForm() {
    if (_dateController == "") {
      _showAlert("Oops!", "Pilih tanggal pengeluaran!");
    } else if (_deskripsiController.text == "") {
      _showAlert("Oops!", "Deskripsi pengeluaran belum di isi!");
    } else if (_jumlahController.text == "") {
      _showAlert("Oops!", "Jumlah pengeluaran belum di isi!");
    } else {
      widget.data.length == 0
          ? _addPengeluaran()
          : _updatePengeluaran(widget.data.elementAt(0));
    }
  }

  void _showAlert(String alert, String desc) {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertValidation(
              title: alert,
              desc: desc,
              status: false,
            ));
  }

  _onType(String value) {
    setState(() {
      if (value.length > 20 && value.length <= 40) {
        _maxLength = 2;
      } else if (value.length > 40 && value.length <= 80) {
        _maxLength = 3;
      } else if (value.length > 80 && value.length <= 120) {
        _maxLength = 4;
      } else if (value.length > 120 && value.length <= 160) {
        _maxLength = 5;
      } else {
        _maxLength = 1;
      }
    });
  }

  _changeFormatCurrency(String value) {
    setState(() {
      _jumlahController.text = FormatCurrency.addDot(value, 0);
      _jumlahController.selection = TextSelection.fromPosition(
          TextPosition(offset: _jumlahController.text.length));
    });
  }

  @override
  void initState() {
    super.initState();
    theme = AppTheme.theme;
    if (widget.data.length > 0) {
      _deskripsiController.text = widget.data.elementAt(2);
      _jumlahController.text = widget.data.elementAt(3).toString();
      _dateController = widget.data.elementAt(6);
      txtDate = widget.data.elementAt(6);
      selectedDate =
          FormatDateCustom.convertStringToDate(widget.data.elementAt(6));
      _kategoriController = widget.data.elementAt(4);
      _notaController = widget.data.elementAt(5);
      _radioValue = SetOpt.kategori(widget.data.elementAt(4));
      _radioValue2 = SetOpt.nota(widget.data.elementAt(5));
      _onType(_deskripsiController.text);
      _changeFormatCurrency(_jumlahController.text);
    } else {
      selectedDate = DateTime.now();
      _jumlahController.text = "0";
    }
  }

  _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate!,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        String month = "";
        String day = "";
        if (picked.month < 10) {
          month = "0" + picked.month.toString();
        } else {
          month = picked.month.toString();
        }
        if (picked.day < 10) {
          day = "0" + picked.day.toString();
        } else {
          day = picked.day.toString();
        }
        txtDate = picked.year.toString() + "-" + month + "-" + day;
        _dateController = picked.year.toString() + "-" + month + "-" + day;
      });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return SingleChildScrollView(
      child: Dialog(
        child: Container(
          padding: FxSpacing.xy(24, 16),
          decoration: BoxDecoration(
            color: Color(0xfff1f0f6),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: FxSpacing.top(8),
                child: Center(
                    child: FxText.sh1(
                        widget.data.length == 0
                            ? this.widget.title
                            : this.widget.titleUpdate,
                        fontWeight: 700)),
              ),
              FxSpacing.height(16),
              Divider(
                color: theme.dividerColor,
                thickness: 1,
                height: 0,
              ),
              FxSpacing.height(16),
              Container(
                padding: FxSpacing.fromLTRB(0, 0, 16, 8),
                child: FxText.sh2("Tanggal Pengeluaran", fontWeight: 500),
              ),
              Container(
                margin: EdgeInsets.only(left: 0),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    boxShadow: [
                      BoxShadow(
                        color: themeData.colorScheme.primary.withAlpha(24),
                        blurRadius: 2,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: InkWell(
                    onTap: () {
                      _pickDate(context);
                    },
                    child: Padding(
                      padding: FxSpacing.x(16),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            MdiIcons.calendarOutline,
                            color: themeData.colorScheme.primary,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: FxText.b2(
                              txtDate,
                              fontSize: 16,
                              fontWeight: 500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: FxSpacing.fromLTRB(0, 16, 16, 8),
                child: FxText.sh2("Deskripsi", fontWeight: 500),
              ),
              Container(
                padding: FxSpacing.x(0),
                child: CupertinoTextField(
                  controller: _deskripsiController,
                  maxLines: _maxLength,
                  onChanged: _onType,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    boxShadow: [
                      BoxShadow(
                        color: themeData.colorScheme.primary.withAlpha(24),
                        blurRadius: 2,
                        offset: Offset(0, 1),
                      ),
                    ],
                    border: Border.all(
                        color: theme.colorScheme.primary.withAlpha(0)),
                    color: Colors.white,
                  ),
                  cursorColor: theme.colorScheme.primary,
                  placeholder: "Deskripsi pengeluaran",
                  prefix: Padding(
                    padding: FxSpacing.left(16),
                    child: Icon(
                      Icons.edit,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  style: TextStyle(color: theme.colorScheme.onBackground),
                  padding: FxSpacing.xy(8, 16),
                  placeholderStyle: TextStyle(
                      color: theme.colorScheme.onBackground.withAlpha(160)),
                ),
              ),
              FxSpacing.height(16),
              Container(
                padding: FxSpacing.fromLTRB(0, 0, 16, 8),
                child: FxText.sh2("Jumlah pengeluaran", fontWeight: 500),
              ),
              Container(
                padding: FxSpacing.x(0),
                child: CupertinoTextField(
                  controller: _jumlahController,
                  keyboardType: TextInputType.number,
                  onChanged: _changeFormatCurrency,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      boxShadow: [
                        BoxShadow(
                          color: themeData.colorScheme.primary.withAlpha(24),
                          blurRadius: 2,
                          offset: Offset(0, 1),
                        ),
                      ],
                      border: Border.all(
                          color: theme.colorScheme.primary.withAlpha(0)),
                      color: Colors.white),
                  cursorColor: theme.colorScheme.primary,
                  placeholder: "Jumlah",
                  prefix: Padding(
                    padding: FxSpacing.left(16),
                    child: Icon(
                      Icons.payment_outlined,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  style: TextStyle(color: theme.colorScheme.onBackground),
                  padding: FxSpacing.xy(8, 16),
                  placeholderStyle: TextStyle(
                      color: theme.colorScheme.onBackground.withAlpha(160)),
                ),
              ),
              FxSpacing.height(16),
              Container(
                padding: FxSpacing.fromLTRB(0, 0, 16, 8),
                child: FxText.sh2("Kategori", fontWeight: 500),
              ),
              Center(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: FxText.sh2("Transport", fontWeight: 600),
                        contentPadding: EdgeInsets.all(0),
                        dense: true,
                        leading: Radio(
                          value: 1,
                          activeColor: theme.colorScheme.primary,
                          groupValue: _radioValue,
                          onChanged: (int? value) {
                            setState(() {
                              _radioValue = value;
                              _kategoriController = "Transport";
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: FxText.sh2("Akomodasi", fontWeight: 600),
                        contentPadding: EdgeInsets.all(0),
                        dense: true,
                        leading: Radio(
                          value: 2,
                          activeColor: theme.colorScheme.primary,
                          groupValue: _radioValue,
                          onChanged: (int? value) {
                            setState(() {
                              _radioValue = value;
                              _kategoriController = "Akomodasi";
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: FxText.sh2("Material", fontWeight: 600),
                        contentPadding: EdgeInsets.all(0),
                        dense: true,
                        leading: Radio(
                          value: 3,
                          activeColor: theme.colorScheme.primary,
                          groupValue: _radioValue,
                          onChanged: (int? value) {
                            setState(() {
                              _radioValue = value;
                              _kategoriController = "Material";
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: FxText.sh2("Lain-lain", fontWeight: 600),
                        contentPadding: EdgeInsets.all(0),
                        dense: true,
                        leading: Radio(
                          value: 4,
                          activeColor: theme.colorScheme.primary,
                          groupValue: _radioValue,
                          onChanged: (int? value) {
                            setState(() {
                              _radioValue = value;
                              _kategoriController = "Lain-lain";
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: FxText.sh2("Uang Saku", fontWeight: 600),
                        contentPadding: EdgeInsets.all(0),
                        dense: true,
                        leading: Radio(
                          value: 5,
                          activeColor: theme.colorScheme.primary,
                          groupValue: _radioValue,
                          onChanged: (int? value) {
                            setState(() {
                              _radioValue = value;
                              _kategoriController = "Uang Saku";
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              FxSpacing.height(16),
              Container(
                padding: FxSpacing.fromLTRB(0, 0, 16, 8),
                child: FxText.sh2("Nota", fontWeight: 500),
              ),
              Center(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: FxText.sh2("Dengan Nota", fontWeight: 600),
                        contentPadding: EdgeInsets.all(0),
                        dense: true,
                        leading: Radio(
                          value: 1,
                          activeColor: theme.colorScheme.primary,
                          groupValue: _radioValue2,
                          onChanged: (int? value) {
                            setState(() {
                              _radioValue2 = value;
                              _notaController = "Dengan Nota";
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: FxText.sh2("Tanpa Nota", fontWeight: 600),
                        contentPadding: EdgeInsets.all(0),
                        dense: true,
                        leading: Radio(
                          value: 2,
                          activeColor: theme.colorScheme.primary,
                          groupValue: _radioValue2,
                          onChanged: (int? value) {
                            setState(() {
                              _radioValue2 = value;
                              _notaController = "Tanpa Nota";
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              FxSpacing.height(24),
              Divider(
                color: theme.dividerColor,
                thickness: 1,
                height: 0,
              ),
              Container(
                margin: FxSpacing.top(8),
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                child: Row(children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: Container(
                        child: Center(
                          child: FxButton.block(
                              backgroundColor: Colors.redAccent,
                              elevation: 0,
                              borderRadiusAll: 4,
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: FxText.caption("Batal",
                                  fontWeight: 600,
                                  letterSpacing: 0.4,
                                  color: themeData.colorScheme.onPrimary)),
                        ),
                      )),
                  FxSpacing.width(16),
                  Expanded(
                      flex: 1,
                      child: Container(
                        child: Center(
                          child: FxButton.block(
                              backgroundColor: themeData.colorScheme.primary,
                              elevation: 0,
                              borderRadiusAll: 4,
                              onPressed: () {
                                validateForm();
                              },
                              child: FxText.caption("Simpan",
                                  fontWeight: 600,
                                  letterSpacing: 0.4,
                                  color: themeData.colorScheme.onPrimary)),
                        ),
                      )),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showSnackbarWithFloating(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: FxText.sh2(message, color: theme.colorScheme.onPrimary),
        backgroundColor: theme.colorScheme.primary,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
