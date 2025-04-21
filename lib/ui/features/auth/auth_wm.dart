import 'package:flutter/material.dart';
import 'package:elementary/elementary.dart';
import 'package:petsder/data/models/enums/auth_state.dart';
import 'package:petsder/ui/features/auth/auth_widget.dart';

import 'auth_model.dart';
abstract interface class IAuthWidgetModel implements IWidgetModel {
  ValueNotifier<AuthState> get authListenable;
}

AuthWidgetModel defaultAuthWidgetModelFactory(BuildContext context) {
  return AuthWidgetModel(AuthModel());
}

class AuthWidgetModel extends WidgetModel<AuthScreen, IAuthModel> implements IAuthWidgetModel {AuthWidgetModel(AuthModel super.model);

  final _authStateEntity = ValueNotifier<AuthState>(AuthState.login);

  @override
  ValueNotifier<AuthState> get authListenable => _authStateEntity;
  
}