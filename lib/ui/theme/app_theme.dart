import 'theme.dart';
import 'package:flutter/material.dart';

class AppTheme extends StatelessWidget {
  const AppTheme({
    super.key, 
    required this.data, 
    required this.child
  });

  final AppThemeData data;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return _InheritedStTheme(
      theme: this,
      child: child,
    );
  }

  static AppThemeData of(BuildContext context) {
    final inheritedTheme = context.dependOnInheritedWidgetOfExactType<_InheritedStTheme>();
    assert(inheritedTheme != null, 'No instance of AppThemeData present in the widget tree.');
    return inheritedTheme!.theme.data;
  }
}

class _InheritedStTheme extends InheritedTheme {
  const _InheritedStTheme({
    required this.theme,
    required super.child,
  });
  final AppTheme theme;

  @override
  Widget wrap(BuildContext context, Widget child) {
    final ancestorTheme = context.findAncestorWidgetOfExactType<_InheritedStTheme>();
    return identical(this, ancestorTheme) ? child : AppTheme(data: theme.data, child: child);
  }

  @override
  bool updateShouldNotify(_InheritedStTheme old) => theme.data != old.theme.data;
}