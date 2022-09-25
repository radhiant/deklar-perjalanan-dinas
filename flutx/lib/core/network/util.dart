class FxNetworkUtil{

  static String formatUrl(String url) {
    if (url[url.length - 1] == "/") return url.substring(0, url.length - 1);
    return url;
  }

  static Uri parseToUri(String url, {bool format = false}) {
    if (format) {
      return Uri.parse(formatUrl(url));
    }
    return Uri.parse(url);
  }

}