import 'package:flutter/material.dart';
import 'package:petsder/common/utils/di/app_async_dependency.dart';
import 'package:petsder/common/utils/di/scopes/global/global_scope.dart';

import 'common/app/app.dart';
import 'common/utils/di/restart_widget.dart';

void main() {
  runApp(
    RestartWidget(
      child: AsyncDependencyWidget<GlobalDependency>(
      create: GlobalDependency.new,
      loaderBuilder: (context) => const Placeholder(),
      errorBuilder: (context, e) => const Placeholder(),
      child: const PetsderApp(),
      )
    )
  );
}

