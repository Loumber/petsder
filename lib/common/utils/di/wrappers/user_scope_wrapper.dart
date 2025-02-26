import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:petsder/common/utils/di/app_async_dependency.dart';
import 'package:petsder/common/utils/di/scopes/user_info/user_info_scope.dart';
import 'package:petsder/ui/features/app_lodaing_error.dart/app_loading_error_widget.dart';

import '../../../../ui/features/splash/default_logo_for_splash.dart';


@RoutePage()
class UserWrapperScreen extends StatelessWidget {
  const UserWrapperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AsyncDependencyWidget(
      create: UserInfoDependency.new,
      errorBuilder: (context, e) => const AppLoadingErrorWidget(),
      loaderBuilder: (context) => const DefaultLogoForSplash(), 
      child: const AutoRouter(),
    );
  }
}