import 'package:deklarasi/helper/db_deklar/sql_helper.dart';
import 'package:deklarasi/theme/app_theme.dart';
import 'package:deklarasi/utils/formatDate.dart';
import 'package:deklarasi/utils/formatcurrency.dart';
import 'package:deklarasi/widgets/alert_validation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class FormSuratDialog extends StatefulWidget {
  final String title, titleUpdate;
  final int idkaryawan;
  final bool status;
  final Iterable<dynamic> data;

  FormSuratDialog(
      {required this.title,
      this.status = false,
      this.titleUpdate = "",
      required this.idkaryawan,
      required this.data});

  @override
  State<FormSuratDialog> createState() => _FormSuratDialogState();
}

class _FormSuratDialogState extends State<FormSuratDialog> {
  DateTime? selectedDate;

  late ThemeData theme;
  String txtDate = "Pilih Tanggal";

  final TextEditingController _judulsuratController = TextEditingController();
  final TextEditingController _anggaranController = TextEditingController();
  String _dateController = '';
  int _maxLength = 1;

  Future<void> _addSurat() async {
    await SQLHelper.createItem(
        _judulsuratController.text,
        FormatCurrency.removeSC(_anggaranController.text),
        _dateController,
        widget.idkaryawan);
    Navigator.of(context).pop('refresh');
  }

  Future<void> _updateItem(int id) async {
    await SQLHelper.updateItem(
        id,
        _judulsuratController.text,
        int.parse(FormatCurrency.removeSC(_anggaranController.text)),
        _dateController);
    Navigator.of(context).pop('refresh');
  }

  void validateForm() {
    if (_dateController == "") {
      _showAlert("Oops!", "Pilih tanggal terlebih dahulu!");
    } else if (_judulsuratController.text == "") {
      _showAlert("Oops!", "Judul surat belum di isi!");
    } else if (_anggaranController.text == "") {
      _showAlert("Oops!", "Jumlah anggaran belum di isi!");
    } else {
      widget.data.length == 0
          ? _addSurat()
          : _updateItem(widget.data.elementAt(0));
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
      _anggaranController.text = FormatCurrency.addDot(value, 0);
      _anggaranController.selection = TextSelection.fromPosition(
          TextPosition(offset: _anggaranController.text.length));
    });
  }

  @override
  void initState() {
    super.initState();
    theme = AppTheme.theme;
    if (widget.data.length > 0) {
      _judulsuratController.text = widget.data.elementAt(1);
      _anggaranController.text = widget.data.elementAt(2).toString();
      _dateController = widget.data.elementAt(3);
      txtDate = widget.data.elementAt(3);
      selectedDate =
          FormatDateCustom.convertStringToDate(widget.data.elementAt(3));
      _onType(_judulsuratController.text);
      _changeFormatCurrency(_anggaranController.text);
    } else {
      selectedDate = DateTime.now();
      _anggaranController.text = "0";
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
      padding: FxSpacing.top(75),
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
                child: FxText.sh2("Tanggal Surat", fontWeight: 500),
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
                      ]),
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
                child: FxText.sh2("Judul Surat", fontWeight: 500),
              ),
              Container(
                padding: FxSpacing.x(0),
                child: CupertinoTextField(
                  controller: _judulsuratController,
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
                      color: Colors.white),
                  cursorColor: theme.colorScheme.primary,
                  placeholder: "Judul surat",
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
                child: FxText.sh2("Anggaran", fontWeight: 500),
              ),
              Container(
                padding: FxSpacing.x(0),
                child: CupertinoTextField(
                  keyboardType: TextInputType.number,
                  controller: _anggaranController,
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
                  placeholder: "Anggaran",
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
                                Navigator.of(context).pop("batal");
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
