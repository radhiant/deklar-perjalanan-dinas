// Copyright 2021 The FlutX Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// [FxDistanceUtils] - gives different functions that can be used for calculating or formatting distance


import 'dart:math';

class FxLatLng {
  final double latitude, longitude;

  FxLatLng(this.latitude, this.longitude);
}

class FxDistanceUtils {
  static String formatDistance(double distance) {
    if (distance > 1000) {
      distance = distance / 1000;
      return (distance).toStringAsFixed(
              distance.truncateToDouble() == distance ? 0 : 2) +
          " KM";
    } else {
      return distance.floor().toString() + " Meter";
    }
  }

  static double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos as double Function(num?);
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * 1000 * asin(sqrt(a));
  }

  static double calculateDistanceBetweenTwoLtnLng(
      FxLatLng origin, FxLatLng destination) {
    double lat1 = origin.latitude;
    double lon1 = origin.longitude;
    double lat2 = destination.latitude;
    double lon2 = destination.longitude;
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }
}
