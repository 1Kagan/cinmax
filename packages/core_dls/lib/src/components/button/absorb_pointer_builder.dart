import 'package:flutter/material.dart';

class AbsorbPointerBuilder<T> extends StatefulWidget {
  const AbsorbPointerBuilder({
    super.key,
    required this.builder,
    required this.asyncAction,
    required this.child,
  });

  final AbsorbWidgetBuilder<T> builder;
  final Future<T> Function()? asyncAction;
  final Widget child;

  @override
  State<AbsorbPointerBuilder<T>> createState() =>
      _AbsorbPointerBuilderState<T>();
}

typedef AbsorbWidgetBuilder<T> = Widget Function(
  BuildContext context,
  AsyncSnapshot<T> snapshot,
  Widget child,
);

class _AbsorbPointerBuilderState<T> extends State<AbsorbPointerBuilder<T>> {
  Object? _activeCallbackIdentity;
  late AsyncSnapshot<T> _snapshot;

  @override
  void initState() {
    super.initState();
    _snapshot = AsyncSnapshot<T>.withData(
        ConnectionState.none, widget.asyncAction as T);
    _subscribe();
  }

  @override
  void didUpdateWidget(AbsorbPointerBuilder<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.asyncAction != widget.asyncAction) {
      if (_activeCallbackIdentity != null) {
        _unsubscribe();
        _snapshot = _snapshot.inState(ConnectionState.none);
      }
      _subscribe();
    }
  }

  @override
  Widget build(BuildContext context) => widget.builder(
        context,
        _snapshot,
        AbsorbPointer(
          absorbing: _snapshot.connectionState != ConnectionState.waiting,
          child: widget.child,
        ),
      );

  @override
  void dispose() {
    _unsubscribe();
    super.dispose();
  }

  void _subscribe() async {
    if (widget.asyncAction != null) {
      final callbackIdentity = Object();
      _activeCallbackIdentity = callbackIdentity;
      widget.asyncAction!.call().then<void>(
        (T data) {
          if (_activeCallbackIdentity == callbackIdentity) {
            setState(() {
              _snapshot = AsyncSnapshot<T>.withData(ConnectionState.done, data);
            });
          }
        },
        onError: (Object error, StackTrace stackTrace) {
          if (_activeCallbackIdentity == callbackIdentity) {
            setState(() {
              _snapshot = AsyncSnapshot<T>.withError(
                  ConnectionState.done, error, stackTrace);
            });
          }
          assert(
            () {
              if (FutureBuilder.debugRethrowError) {
                Future<Object>.error(error, stackTrace);
              }
              return true;
            }(),
            '',
          );
        },
      );
      _snapshot = _snapshot.inState(ConnectionState.waiting);
    }
  }

  void _unsubscribe() {
    _activeCallbackIdentity = null;
  }
}
