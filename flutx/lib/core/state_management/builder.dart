
import 'package:flutter/material.dart';
import 'controller.dart';

typedef FxControllerBuilder<T> = Widget Function(T controller);

class FxBuilder<T extends FxController> extends StatefulWidget {
  final FxControllerBuilder<T> builder;
  final T? controller;

  final void Function(FxBuilderState<T> state)? initState, dispose, didChangeDependencies;
  final void Function(FxBuilder oldWidget, FxBuilderState<T> state)? didUpdateWidget;

  const FxBuilder({
    Key? key,
    required this.controller,
    required this.builder,
    this.initState,
    this.dispose,
    this.didChangeDependencies,
    this.didUpdateWidget,
  }) : super(key: key);

  @override
  FxBuilderState<T> createState() => FxBuilderState<T>();
}

class FxBuilderState<T extends FxController>
    extends State<FxBuilder<T>> //with GetStateUpdaterMixin
{
  T? controller;
  VoidCallback? _remove;

  @override
  void initState() {
    super.initState();
    widget.initState?.call(this);
    controller = widget.controller;
    controller?.context = context;
    controller?.initState();
    _subscribeToController();
  }


  @override
  void deactivate() {
    super.deactivate();
  }


  /// Register to listen Controller's events.
  /// It gets a reference to the remove() callback, to delete the
  /// setState "link" from the Controller.
  void _subscribeToController() {
    _remove?.call();
    _remove = controller?.addListener(update);
  }

  void update() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    widget.dispose?.call(this);
    _remove?.call();
    _remove = null;
    controller?.dispose();
    controller = null;
    super.dispose();
  }



  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.didChangeDependencies?.call(this);
  }

  @override
  void didUpdateWidget(FxBuilder oldWidget) {
    super.didUpdateWidget(oldWidget as FxBuilder<T>);
    widget.didUpdateWidget?.call(oldWidget, this);
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(controller!);
  }
}
