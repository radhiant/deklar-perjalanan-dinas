

import 'package:flutter/cupertino.dart';
import 'controller_store.dart';
import 'listenable_mixin.dart';

import 'disposable_interface.dart';

abstract class FxController extends DisposableInterface with ListenableMixin, ListNotifierMixin {

  bool save = true;
  late BuildContext context;


  @protected
  void update() {
    
    refresh();
  }

  /// Implement [getTag] on child controller. Which return unique tag.
  String getTag();

  @override
  void dispose() {
    if(!save) {
      FxControllerStore.delete(this);
      super.dispose();
    }
  }







}

