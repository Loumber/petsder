import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:petsder/domain/overlay_bloc/overlay_bloc.dart';
import 'package:petsder/domain/overlay_bloc/overlay_bloc_events.dart';
import 'package:petsder/domain/pet/pet_repository.dart';

abstract interface class IEditPetModel extends ElementaryModel{

  void showOverlayNotification(Widget widget);

  Future<void> editName(String name);

}

class EditPetModel extends IEditPetModel {

  EditPetModel(
    this._petRepository,
    this._overlayBloc
  );


  final PetRepository _petRepository;

  final OverlayBloc _overlayBloc;

  @override 
  void showOverlayNotification(Widget widget)  =>
    _overlayBloc.add(OverlayBlocShowEvent(notificationWidget: widget, duration: const Duration(seconds: 3)));

  @override
  Future<void> editName(String name) async {
    try {
      await _petRepository.editPetName(name);
    } on Object {
      rethrow;
    }
  }
}