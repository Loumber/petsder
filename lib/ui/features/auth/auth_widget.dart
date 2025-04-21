import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:petsder/data/models/enums/auth_state.dart';

import 'auth_wm.dart';
import 'login/login_widget.dart';
import 'registration/registration_widget.dart';

@RoutePage()
class AuthScreen extends ElementaryWidget<IAuthWidgetModel> {
  const AuthScreen({
    super.key
  }):super(defaultAuthWidgetModelFactory);

  @override
  Widget build(IAuthWidgetModel wm) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ValueListenableBuilder<AuthState>(
        valueListenable: wm.authListenable, 
        builder: (context, state, _) {  
          return state == AuthState.login 
            ? LoginScreen(
              state: wm.authListenable,
            ) 
            : RegistrationScreen(
              state: wm.authListenable,
            );
        },
      ),
    );
  }
}