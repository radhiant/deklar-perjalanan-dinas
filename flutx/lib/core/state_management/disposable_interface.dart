

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'lifecycle.dart';

abstract class DisposableInterface extends FxLifeCycle
    {
  /// Called immediately after the widget is allocated in memory.
  /// You might use this to initialize something for the controller.
  @override
  @mustCallSuper
  void initState() {
    super.initState();
    SchedulerBinding.instance?.addPostFrameCallback((_) => onReady());
  }

  /// Called 1 frame after onInit(). It is the perfect place to enter
  /// navigation events, like snackbar, dialogs, or a new route, or
  /// async request.
  @override
  void onReady() {
     super.onReady();
  }

  /// Called before [onDelete] method. [onClose] might be used to
  /// dispose resources used by the controller. Like closing events,
  /// or streams before the controller is destroyed.
  /// Or dispose objects that can potentially create some memory leaks,
  /// like TextEditingControllers, AnimationControllers.
  /// Might be useful as well to persist some data on disk.
  @override
  void dispose() {
     super.dispose();
  }

}
