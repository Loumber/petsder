
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:petsder/common/utils/di/app_async_dependency.dart';
import 'package:petsder/common/utils/di/scopes/user_info/user_info_scope.dart';


@RoutePage()
class UserWrapperScreen extends StatelessWidget {
  const UserWrapperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AsyncDependencyWidget(
      create: UserInfoDependency.new,
      errorBuilder: (context, e) => const Placeholder(),
      loaderBuilder: (context) => const Placeholder(), 
      child: const AutoRouter(),
    );
  }
}