import 'package:auto_route/auto_route.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:elementary/elementary.dart';
import 'package:petsder/common/utils/di/scopes/global/global_scope.dart';
import 'package:petsder/common/utils/di/scopes/user_info/user_info_scope.dart';
import 'package:petsder/common/utils/extensions/widget_model_extensions.dart';
import 'package:petsder/common/utils/navigation/app_router.dart';
import 'package:petsder/ui/features/auth/registration/registration_model.dart';
import 'package:petsder/ui/theme/theme.dart';

import '../../../../data/models/enums/auth_state.dart';
import 'registration_widget.dart';

abstract interface class IRegistrationWidgetModel implements IWidgetModel {

  ValueNotifier<EntityState<void>> get registrationListenable;

  TextEditingController get emailController;

  TextEditingController get passwordController;
  
  Future<void> onSignInPressed();

  void onLoginTap();

  AppThemeData get theme;
  MediaQueryData get mediaQuaery;
}

RegistrationWidgetModel defaultRegistrationWidgetModelFactory(BuildContext context) {
  return RegistrationWidgetModel(RegistrationModel(
    context.user.authRepository,
    context.global.overlayBloc
  ));
}

class RegistrationWidgetModel extends WidgetModel<RegistrationScreen, IRegistrationModel>
    implements IRegistrationWidgetModel {
  RegistrationWidgetModel(RegistrationModel super.model);

  @override
  MediaQueryData get mediaQuaery => wmMediaQuery;

  @override
  AppThemeData get theme => wmTheme;

  final _registrationEntity = EntityStateNotifier<void>();

  @override
  ValueNotifier<EntityState<void>> get registrationListenable => _registrationEntity;

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  @override
  TextEditingController get emailController => _emailController;

  @override
  TextEditingController get passwordController => _passwordController;

  @override
  Future<void> onSignInPressed() async {
    try{
      
      await model.signUp( _emailController.text, _passwordController.text);
      // ignore: use_build_context_synchronously 
      context.router.push(const AddPetRoute());
    } on Exception {
      model.showOverlayNotification(const Text('Не удалось зарегистрироваться'));
    }
  }
  
  @override
  void onLoginTap() {
    widget.state.value = AuthState.login;
  }

}