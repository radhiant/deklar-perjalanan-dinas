import 'dart:developer';

import 'package:flutter/material.dart';

typedef Disposer = void Function();

typedef FxStateUpdate = void Function();

mixin ListNotifierMixin on ListenableMixin {

  List<FxStateUpdate?>? _updaters = <FxStateUpdate?>[];


  @protected
  void refresh() {
    // assert(_debugAssertNotDisposed());

    /// This debounce the call to update.
    /// It prevent errors and duplicates builds
    if(_updaters!=null) {
      _notifyUpdate();
    }
    else{
      log("FlutX: A $runtimeType was used after being disposed. 'Once you have called dispose() on a $runtimeType, it can no longer be used.");
    }
  }

  void _notifyUpdate() {
    for (var element in _updaters!) {
      element!();
    }
  }


  bool _debugAssertNotDisposed() {
    assert(() {
      if (_updaters == null) {
        throw FlutterError('''A $runtimeType was used after being disposed.\n
'Once you have called dispose() on a $runtimeType, it can no longer be used.''');
      }
      return true;
    }());
    return true;
  }


  bool get hasListeners {
    assert(_debugAssertNotDisposed());
    return _updaters!.isNotEmpty;
  }

  int get listeners {
    assert(_debugAssertNotDisposed());
    return _updaters!.length;
  }

  @override
  void removeListener(VoidCallback listener) {
    assert(_debugAssertNotDisposed());
    _updaters!.remove(listener);
  }

  @mustCallSuper
  void dispose() {
    assert(_debugAssertNotDisposed());
    _updaters = null;
  }

  @override
  Disposer addListener(FxStateUpdate listener) {
    assert(_debugAssertNotDisposed());
    _updaters!.add(listener);
    return () => _updaters!.remove(listener);
  }

  /// To dispose an [id] from future updates(), this ids are registered
  /// by [FxBuilder] or similar, so is a way to unlink the state change with
  /// the Widget from the Controller.

}

mixin ListenableMixin implements Listenable {}
