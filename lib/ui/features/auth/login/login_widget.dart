import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:petsder/ui/widgets/buttons/app_button.dart';

import '../widgets/google_button.dart';
import 'login_wm.dart';

@RoutePage()
class LoginScreen extends ElementaryWidget<ILoginWidgetModel> {
  const LoginScreen({super.key}) : super(defaultLoginWidgetModelFactory);

  @override
  Widget build(ILoginWidgetModel wm) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                      decoration: TextDecoration.underline, 
                    ),
                    children: [
                      TextSpan(
                        text: '/Регистрация', 
                        style: const TextStyle(
                          decoration: TextDecoration.none, 
                        ),
                        recognizer: TapGestureRecognizer()
                        ..onTap = () => wm.onRegistrantionTap(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
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
              padding: const EdgeInsets.all(8.0),
              child: AppButton(
                text: 'Войти', 
                onPressed: wm.onLoginPressed,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Divider(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GoogleButton(
                onTap: wm.onGoogleTap,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
