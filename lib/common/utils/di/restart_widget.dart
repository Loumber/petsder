import 'package:flutter/material.dart';

class RestartWidget extends StatefulWidget {
  const RestartWidget({
    super.key, 
    required this.child
  });

  final Widget child;

  static bool didRestartWidget = false;

  @override
  State<RestartWidget> createState() => _RestartWidgetState();

  static void restartApp(BuildContext context) {
    final _RestartWidgetState? state = context.findAncestorStateOfType<_RestartWidgetState>();
    state?.restartApp();
  }
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}