class SetOpt {
  static int kategori(String value) {
    int result = 1;
    switch (value) {
      case "Transport":
        result = 1;
        break;
      case "Akomodasi":
        result = 2;
        break;
      case "Material":
        result = 3;
        break;
      case "Lain-lain":
        result = 4;
        break;
      case "Uang Saku":
        result = 5;
        break;

      default:
        result = 1;
        break;
    }
    return result;
  }

  static int nota(String value) {
    int result = 1;
    switch (value) {
      case "Dengan Nota":
        result = 1;
        break;
      case "Tanpa Nota":
        result = 2;
        break;
      default:
        result = 1;
        break;
    }
    return result;
  }

  static String defkategori(String value) {
    String result = "";
    switch (value) {
      case "Transport":
        result = "Transport";
        break;
      case "Akomodasi":
        result = "Akomodasi";
        break;
      case "Material":
        result = "Material";
        break;
      case "Uangsaku":
        result = "Uang Saku";
        break;
      case "Lainlain":
        result = "Lain-lain";
        break;
      default:
        result = "Transport";
        break;
    }
    return result;
  }

  static String defNota(String value) {
    String result = "Dengan Nota";
    switch (value) {
      case "Y":
        result = "Dengan Nota";
        break;
      case "N":
        result = "Tanpa Nota";
        break;
      default:
        result = "Dengan Nota";
        break;
    }
    return result;
  }
}
