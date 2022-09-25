class FormatDateCustom {
  static DateTime convertStringToDate(String dateString) {
    String removeSpecialCharacter = dateString.replaceAll(RegExp('-'), '');
    String date = removeSpecialCharacter + "000000";
    String dateWithT = date.substring(0, 8) + 'T' + date.substring(8);
    DateTime dateTime = DateTime.parse(dateWithT);
    return dateTime;
  }

  static String formatIndonesia(String date) {
    var arr = date.split('-');
    String tgl = arr[2];
    String bln = arr[1];
    String namaBulan = "";
    String thn = arr[0];
    switch (bln) {
      case "01":
        namaBulan = "Januari";
        break;
      case "02":
        namaBulan = "Februari";
        break;
      case "03":
        namaBulan = "Maret";
        break;
      case "04":
        namaBulan = "April";
        break;
      case "05":
        namaBulan = "Mei";
        break;
      case "06":
        namaBulan = "Juni";
        break;
      case "07":
        namaBulan = "Juli";
        break;
      case "08":
        namaBulan = "Agustus";
        break;
      case "09":
        namaBulan = "September";
        break;
      case "10":
        namaBulan = "Oktober";
        break;
      case "11":
        namaBulan = "November";
        break;
      case "12":
        namaBulan = "Desember";
        break;
    }
    String formatindo = tgl + " " + namaBulan + " " + thn;
    return formatindo;
  }
}
