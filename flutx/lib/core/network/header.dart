class FxNetworkHeader {
  static Map<String, String> create(
      {FxNetworkRequestType requestType = FxNetworkRequestType.get,
      String? token = ""}) {
    Map<String, String> header = {"Accept": "application/json"};

    switch (requestType) {
      case FxNetworkRequestType.get:
        break;

      case FxNetworkRequestType.post:
      case FxNetworkRequestType.delete:
        header["Content-type"] = "application/json";
        break;

      case FxNetworkRequestType.getWithAuth:
      case FxNetworkRequestType.postWithAuth:
      case FxNetworkRequestType.deleteWithAuth:
        header["Content-type"] = "application/json";
        header["Authorization"] = "Bearer " + token!;
        break;
    }

    return header;
  }
}

enum FxNetworkRequestType {
  get,
  post,
  delete,
  getWithAuth,
  postWithAuth,
  deleteWithAuth
}
