import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:elementary/elementary.dart';
import 'package:petsder/common/utils/di/scopes/global/global_scope.dart';
import 'package:petsder/common/utils/di/scopes/user_info/user_info_scope.dart';
import 'package:petsder/common/utils/extensions/widget_model_extensions.dart';
import 'package:petsder/common/utils/navigation/app_router.dart';
import 'package:petsder/ui/features/auth/login/login_widget.dart';

import '../../../../data/models/enums/auth_state.dart';
import '../../../theme/theme.dart';
import 'login_model.dart';


abstract interface class ILoginWidgetModel implements IWidgetModel {
  
  Future<void> onGoogleTap();

  Future<void> onLoginPressed();

  void onRegistrantionTap();

  TextEditingController get emailController;

  TextEditingController get passwordController;

  AppThemeData get theme;
  
  MediaQueryData get mediaQuaery;
}

LoginWidgetModel defaultLoginWidgetModelFactory(BuildContext context) {
  return LoginWidgetModel(LoginModel(
    context.user.authRepository,
    context.global.overlayBloc,
  ));
}

class LoginWidgetModel extends WidgetModel<LoginScreen, ILoginModel>
    implements ILoginWidgetModel {
  LoginWidgetModel(LoginModel super.model);

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  @override
  TextEditingController get emailController => _emailController;

  @override
  TextEditingController get passwordController => _passwordController;

  @override
  MediaQueryData get mediaQuaery => wmMediaQuery;

  @override
  AppThemeData get theme => wmTheme;

  @override
  void onRegistrantionTap() {
    widget.state.value = AuthState.signUp;
  }

  @override
  Future<void> onGoogleTap() async {
    try{
      await model.loginWithGoogle();
    } on Exception {
      model.showOverlayNotification(const Text('Не удалось войти'));
    }
  }

  @override
  Future<void> onLoginPressed() async {
    try{
      await model.login(_emailController.text, _passwordController.text);

      //await model.getCurrentPet();

      // ignore: use_build_context_synchronously
      context.user.userController.currentPetNotifier.value = null;
      // ignore: use_build_context_synchronously
      context.router.push(MenuRoute());
    } on Exception {
      model.showOverlayNotification(const Text('Не удалось войти'));
    }
  }
}