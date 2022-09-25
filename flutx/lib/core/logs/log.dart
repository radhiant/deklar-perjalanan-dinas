// Copyright 2021 The FlutX Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// [FxLog] - provides a way to print anything in the console-

import 'dart:developer';

class FxLog{

  static bool _enabled = true;

  FxLog(dynamic message){
    if(_enabled)
      log(message.toString());
  }

  static enable(){
    _enabled = true;
  }

  static disable(){
    _enabled = false;
  }

  static isEnabled(){
    return _enabled;
  }




}