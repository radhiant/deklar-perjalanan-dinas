import 'package:intl/intl.dart';

class FormatCurrency {
  static String convertToIdr(dynamic number, int decimalDigit) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: decimalDigit,
    );
    return currencyFormatter.format(number);
  }

  static String addDot(String number, int decimalDigit) {
    String a = number.replaceAll(new RegExp(r'[^\w\s]+'), '');
    if (a == '') {
      return "0";
    } else {
      dynamic b = int.parse(a);
      NumberFormat currencyFormatter = NumberFormat.currency(
        locale: 'id',
        symbol: '',
        decimalDigits: decimalDigit,
      );

      return currencyFormatter.format(b);
    }
  }

  static String removeSC(String number) {
    String a = number.replaceAll(new RegExp(r'[^\w\s]'), '');
    return a;
  }

  static int operatorPlus(int a, int b) {
    int selisih = a - b;
    return selisih;
  }
}
