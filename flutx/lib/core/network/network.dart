import 'dart:convert';

import 'response.dart';
import 'util.dart';
import 'package:http/http.dart' as http;

class FxNetwork {

  static Future<FxNetworkResponse> post(String url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    http.Response response = await http.post(
        FxNetworkUtil.parseToUri(url, format: true),
        headers: headers,
        body: body,
        encoding: encoding);

    return FxNetworkResponse(response.body, response.statusCode, response);
  }

  static Future<FxNetworkResponse> get(String url,
      {Map<String, String>? headers}) async {
    http.Response response = await http.get(
      FxNetworkUtil.parseToUri(url, format: true),
      headers: headers,
    );

    return FxNetworkResponse(response.body, response.statusCode, response);
  }

  static Future<FxNetworkResponse> delete(String url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    http.Response response = await http
        .delete(FxNetworkUtil.parseToUri(url, format: true), headers: headers);

    return FxNetworkResponse(response.body, response.statusCode, response);
  }

  static Future<FxNetworkResponse> put(String url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    http.Response response = await http
        .put(FxNetworkUtil.parseToUri(url, format: true), headers: headers);

    return FxNetworkResponse(response.body, response.statusCode, response);
  }

  static Future<FxNetworkResponse> patch(String url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    http.Response response = await http
        .patch(FxNetworkUtil.parseToUri(url, format: true), headers: headers);

    return FxNetworkResponse(response.body, response.statusCode, response);
  }

  static Future<FxNetworkResponse> head(String url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    http.Response response = await http
        .head(FxNetworkUtil.parseToUri(url, format: true), headers: headers);

    return FxNetworkResponse(response.body, response.statusCode, response);
  }
}
