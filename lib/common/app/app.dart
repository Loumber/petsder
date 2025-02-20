import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../ui/theme/app_theme.dart';
import '../../ui/theme/theme.dart';
import '../utils/di/scopes/global/global_scope.dart';

class PetsderApp extends StatefulWidget {
  const PetsderApp({super.key});

  static final navigatorGlobalKey = GlobalKey<NavigatorState>();
  static NavigatorState get navigatorState {
    if (navigatorGlobalKey.currentState == null) {
      throw Exception("can't provide NavigatorState as it isn't created yet or already disposed");
    }
    return navigatorGlobalKey.currentState!;
  }

  @override
  State<PetsderApp> createState() => _PetsderAppState();
}

class _PetsderAppState extends State<PetsderApp> {
  @override
  Widget build(BuildContext context) {
    final global = context.global;
    return AppTheme(
      data: global.theme,
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaler: TextScaler.noScaling,
        ),
        child: MaterialApp.router(
          theme: materialThemeFromAppTheme(
            global.theme,
            SchedulerBinding.instance.platformDispatcher.platformBrightness,
          ),
          debugShowCheckedModeBanner: false,
          routerDelegate: global.router.delegate(),
          routeInformationParser: global.router.defaultRouteParser(),
        )
      ),
    );
  }
}