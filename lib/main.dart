import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:petsder/common/utils/logger/logger.dart';
import 'package:petsder/firebase_options.dart';

import 'common/app/app.dart';
import 'common/utils/di/app_async_dependency.dart';
import 'common/utils/di/restart_widget.dart';
import 'common/utils/di/scopes/global/global_scope.dart';
import 'ui/features/splash/default_logo_for_splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppLogger.error('Application is starting...');
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    } on Object {
      AppLogger.error('Firebase initialization failed');
  }

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

