import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:petsder/data/models/pet/pet_response.dart';
import 'package:petsder/domain/overlay_bloc/overlay_bloc.dart';
import 'package:petsder/domain/overlay_bloc/overlay_bloc_events.dart';
import 'package:petsder/domain/pet/pet_repository.dart';
import 'package:petsder/domain/user/user_controller.dart';

abstract interface class IEditPetModel extends ElementaryModel{

  PetResponse? getCurrentPet();

  void showOverlayNotification(Widget widget);

  Future<void> editName(String name);

}

class EditPetModel extends IEditPetModel {

  EditPetModel(
    this._userController,
    this._petRepository,
    this._overlayBloc
  );

  final UserController _userController;

  final PetRepository _petRepository;

  final OverlayBloc _overlayBloc;

  @override
  PetResponse? getCurrentPet() {
    return _userController.currentPetNotifier.value;
  }

  @override 
  void showOverlayNotification(Widget widget)  =>
    _overlayBloc.add(OverlayBlocShowEvent(notificationWidget: widget, duration: const Duration(seconds: 3)));

  @override
  Future<void> editName(String name) async {
    await _petRepository.editPetName(name);
  }
}