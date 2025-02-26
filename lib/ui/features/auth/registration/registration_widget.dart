import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:petsder/ui/widgets/buttons/app_button.dart';

import 'registration_wm.dart';


@RoutePage()
class RegistrationScreen extends ElementaryWidget<IRegistrationWidgetModel> {
  const RegistrationScreen({
    super.key
  }):super(defaultRegistrationWidgetModelFactory);

  @override
  Widget build(IRegistrationWidgetModel wm) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.center,
                child: RichText(
                  text: TextSpan(
                    text: 'Вход', 
                    style: TextStyle(
                      color: wm.theme.main.inputFieldLabelColor,
                      fontSize: 18,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => wm.onLoginTap(),
                    children: const [
                      TextSpan(
                        text: '/', 
                      ),
                      TextSpan(
                        text: 'Регистрация', 
                        style: TextStyle(
                          decoration: TextDecoration.underline, 
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: wm.emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Почта',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: wm.passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Пароль',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
                right: 8.0,
                top: 8.0,
                bottom: 136.0
              ),
              child: AppButton(
                text: 'Зарегистрироваться', 
                onPressed: wm.onSignInPressed,
              ),
            ),
          ],
        ), 
      ),
    );
  }
}