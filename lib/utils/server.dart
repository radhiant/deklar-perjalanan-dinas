class Server {
  static String connectServer() {
    String server = "bku";
    String result;
    if (server == "bku") {
      result = "http://bintangku.com/";
    } else if (server == "local") {
      result = "http://192.168.232.56/";
    } else {
      result = "http://192.168.232.56/";
    }

    return result;
  }
}
