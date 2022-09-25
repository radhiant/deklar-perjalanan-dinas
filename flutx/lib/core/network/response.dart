import 'package:http/http.dart' as http;

class FxNetworkResponse {
  late String _body;
  late int _statusCode;
  late http.Response _baseResponse;

  FxNetworkResponse(String body, int statusCode, http.Response baseResponse) {
    this._body = body;
    this._statusCode = statusCode;
    this._baseResponse = baseResponse;
  }

  int get statusCode => _statusCode;

  String get body => _body;

  http.Response get baseResponse => _baseResponse;
}
