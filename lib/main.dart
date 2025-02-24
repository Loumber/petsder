import 'package:flutter/material.dart';

import 'common/app/app.dart';
import 'common/utils/di/app_async_dependency.dart';
import 'common/utils/di/restart_widget.dart';
import 'common/utils/di/scopes/global/global_scope.dart';
import 'ui/features/splash/default_logo_for_splash.dart';

void main() {
  runApp(
    RestartWidget(
      child: AsyncDependencyWidget<GlobalDependency>(
      create: GlobalDependency.new,
      loaderBuilder: (context) => const DefaultLogoForSplash(),
      errorBuilder: (context, e) => const Placeholder(),
      child: const PetsderApp(),
      )
    )
  );
}

