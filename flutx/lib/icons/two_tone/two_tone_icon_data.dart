// Copyright 2021 The FlutX Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// [FxTwoToneIconData] - gives path of the Icons.

class FxTwoToneIconData {

  final String name;
  final String extension;
  final String iconPack;

  const FxTwoToneIconData(this.name,{this.extension = "svg",this.iconPack ="mdi"});


  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType)
      return false;
    return other is FxTwoToneIconData
        && name == other.name
        && extension == other.extension
        && iconPack == other.iconPack;
  }


  @override
  int get hashCode => super.hashCode;


  String get path{
    return "packages/flutx/assets/icons/two_tone/"+ iconPack +"/"+ name + "." + extension;
  }

  @override
  String toString() {
    return 'FxTwoToneIconData{name: $name, extension: $extension, iconPack: $iconPack}';
  }
}

class FxTwoToneIconDataCache{

  static Map<FxTwoToneIconData,String> cache = {};

}