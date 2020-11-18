import 'package:flutter/material.dart';

typedef WidgetBuilder<T> = Widget Function(BuildContext context, T snapshot);

class FutureBuilderWidget<T> extends StatefulWidget {
  const FutureBuilderWidget({
    Key key,
    @required this.future,
    this.initialData,
    @required this.builder,
    this.loadingIndicator,
  })  : assert(builder != null),
        super(key: key);

  final  Future<T> future;

  final WidgetBuilder<T> builder;

  final T initialData;

  final Widget loadingIndicator;

  @override
  _FutureLoadingBuilderState<T> createState() =>
      _FutureLoadingBuilderState<T>();
}

class _FutureLoadingBuilderState<T> extends State<FutureBuilderWidget<T>> {
  Future<T> future;

  @override
  void initState() {
    super.initState();
    future = widget.future;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      initialData: widget.initialData,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:

          case ConnectionState.waiting:
            return widget.loadingIndicator ??
                Center(child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                ));
          case ConnectionState.active:
          case ConnectionState.done:
            return widget.builder(context, snapshot.data);
        }
        return widget.builder(context, snapshot.data);
      },
    );
  }
}