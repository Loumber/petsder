import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

import '../../../../domain/auth/auth_repository.dart';
import '../../../../domain/overlay_bloc/overlay_bloc.dart';
import '../../../../domain/overlay_bloc/overlay_bloc_events.dart';
abstract interface class ILoginModel extends ElementaryModel{

  Future<void> login(String email, String password);

  Future<void> loginWithGoogle();

  void showOverlayNotification(Widget widget);
}

class LoginModel extends ILoginModel {
  LoginModel(
    this._authRepository,
    this._overlayBloc,
  );

  final AuthRepository _authRepository;

  final OverlayBloc _overlayBloc;

  @override
  Future<void> login(String email, String password) async {
    try {
      await _authRepository.loginEmailPassword(email, password);
    } on Object catch (e, stackTrace) {
      Error.throwWithStackTrace(e, stackTrace);
    }
  }

  @override
  Future<void> loginWithGoogle() async {
    try {
      await _authRepository.signInWithGoogle();
    } on Object catch (e, stackTrace) {
      Error.throwWithStackTrace(e, stackTrace);
    }
  }

  @override
  void showOverlayNotification(Widget widget) =>
    _overlayBloc.add(OverlayBlocShowEvent(notificationWidget: widget, duration: const Duration(seconds: 3)));
  
}