import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:petsder/data/models/pet/pet_response.dart';
import 'package:petsder/domain/overlay_bloc/overlay_bloc.dart';
import 'package:petsder/domain/overlay_bloc/overlay_bloc_events.dart';
import 'package:petsder/domain/pet/pet_repository.dart';
abstract interface class ILikesModel extends ElementaryModel{
  Future<List<PetResponse>> getLikesPet();

  void showOverlayNotification(Widget widget);

  Future<void> setLike(String likedPetId, String fromPetId);
}

class LikesModel extends ILikesModel {

  LikesModel(this._petRepository, this._overlayBloc);

  final OverlayBloc _overlayBloc;

  final PetRepository _petRepository;


  @override
  Future<List<PetResponse>> getLikesPet() {
    try{
      return _petRepository.getLikesPet();
    }on Object{
      rethrow;
    }
  }

  @override
  Future<void> setLike(String likedPetId, String fromPetId) async {
    try{
      await _petRepository.likePet(likedPetId, fromPetId);
    } on Object {
      rethrow;
    }
  }

  @override 
  void showOverlayNotification(Widget widget)  =>
    _overlayBloc.add(OverlayBlocShowEvent(notificationWidget: widget, duration: const Duration(seconds: 3)));
}