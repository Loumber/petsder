import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:petsder/domain/overlay_bloc/overlay_bloc_events.dart';

import '../../../../domain/auth/auth_repository.dart';
import '../../../../domain/overlay_bloc/overlay_bloc.dart';
abstract interface class IRegistrationModel extends ElementaryModel{
  
  Future<void> signUp(String email, String password);

  void showOverlayNotification(Widget widget);
}

class RegistrationModel extends IRegistrationModel {

  RegistrationModel(
    this._authRepository,
    this._overlayBloc,
  );

  final AuthRepository _authRepository;

  final OverlayBloc _overlayBloc;

  @override 
  Future<void> signUp(String email, String password) async {
    try {
      _authRepository.signUpEmailPassword(email, password);
      
    } on Object catch (e, stackTrace) {
      Error.throwWithStackTrace(e, stackTrace);
    }
  }

  @override 
  void showOverlayNotification(Widget widget)  =>
    _overlayBloc.add(OverlayBlocShowEvent(notificationWidget: widget, duration: const Duration(seconds: 3)));

  
}