import 'package:elementary/elementary.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petsder/data/models/pet/pet_response.dart';
import 'package:petsder/domain/overlay_bloc/overlay_bloc.dart';
import 'package:petsder/domain/overlay_bloc/overlay_bloc_events.dart';
import 'package:petsder/domain/pet/pet_repository.dart';
import 'package:petsder/domain/user/user_controller.dart';
abstract interface class IAccountModel extends ElementaryModel{

  Future<List<PetResponse>> getPets();

  Future<void> changePassword(String newPassword);

  Future<void> signOut();

  PetResponse? getCurrentPet();

  void showOverlayNotification(Widget widget);
}

class AccountModel extends IAccountModel {

  AccountModel(
    this._petRepository,
    this._userController,
    this._overlayBloc
  );

  final OverlayBloc _overlayBloc;

  final PetRepository _petRepository;

  final UserController _userController;
  
  @override
  Future<List<PetResponse>> getPets() async {
    try{
      final res = _petRepository.getPets();
      return res;
    } on Object catch (e, stackTrace) {
      Error.throwWithStackTrace(e, stackTrace);
    } 
  }

  @override
  PetResponse? getCurrentPet() {
    return _userController.currentPetNotifier.value;
  }

  @override
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    _userController.currentPetNotifier.value = null;
  }

  @override
  Future<void> changePassword(String newPassword) async {
    try{
      final user = FirebaseAuth.instance.currentUser;
      await user?.updatePassword(newPassword);
      await FirebaseAuth.instance.currentUser?.reload();
    } on Object{
      rethrow;
    }
  }

  @override 
  void showOverlayNotification(Widget widget)  =>
    _overlayBloc.add(OverlayBlocShowEvent(notificationWidget: widget, duration: const Duration(seconds: 3)));
}