import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:petsder/data/models/animal/animal_response.dart';
import 'package:petsder/data/models/editable_photo/editable_photo.dart';
import 'package:petsder/domain/animal/animal_repository.dart';
import 'package:petsder/domain/overlay_bloc/overlay_bloc.dart';
import 'package:petsder/domain/overlay_bloc/overlay_bloc_events.dart';
import 'package:petsder/domain/pet/pet_repository.dart';

abstract interface class IEditPetModel extends ElementaryModel {
  void showOverlayNotification(Widget widget);

  Future<List<AnimalResponse>> getAnimals();

  Future<void> editPhotos(String petId, List<String> oldUrls, List<EditablePhoto?> newPhotos);

  Future<void> editName(String name);

  Future<void> editType(String petId, String oldType, String oldBreed, String gender, String newType);

  Future<void> editGender(String petId, String type, String oldBreed, String gender, String newGender);

  Future<void> editBreed(String petId, String type, String oldBreed, String newBreed, String gender);

  Future<void> editBirth(String birth);

  Future<void> editDescription(String description);
}

class EditPetModel extends IEditPetModel {
  EditPetModel(this._petRepository, this._animalRepository, this._overlayBloc);

  final AnimalRepository _animalRepository;

  final PetRepository _petRepository;

  final OverlayBloc _overlayBloc;

  @override
  Future<void> editPhotos(String petId, List<String> oldUrls, List<EditablePhoto?> newPhotos) async {
    try {
      await _petRepository.updatePetPhotos(petId: petId, updatedPhotos: newPhotos);
    } on Object {
      rethrow;
    }
  }

  @override
  void showOverlayNotification(Widget widget) =>
      _overlayBloc.add(OverlayBlocShowEvent(notificationWidget: widget, duration: const Duration(seconds: 3)));

  @override
  Future<void> editName(String name) async {
    try {
      await _petRepository.editPetName(name);
    } on Object {
      rethrow;
    }
  }

  @override
  Future<List<AnimalResponse>> getAnimals() async {
    try {
      return await _animalRepository.allAniamls();
    } on Object {
      rethrow;
    }
  }

  @override
  Future<void> editBirth(String birth) async {
    try {
      await _petRepository.editBirth(birth);
    } on Object {
      rethrow;
    }
  }

  @override
  Future<void> editDescription(String description) async {
    try {
      await _petRepository.editDescriptionName(description);
    } on Object {
      rethrow;
    }
  }

  @override
  Future<void> editType(String petId, String oldType, String oldBreed, String gender, String newType) async {
    try {
      await _petRepository.editPetType(
          petId: petId, oldType: oldType, oldBreed: oldBreed, gender: gender, newType: newType);
    } on Object {
      rethrow;
    }
  }

  @override
  Future<void> editGender(String petId, String type, String oldBreed, String gender, String newGender) async {
    try {
      await _petRepository.editPetGender(
          petId: petId, type: type, oldBreed: oldBreed, oldGender: gender, newGender: newGender);
    } on Object {
      rethrow;
    }
  }

  @override
  Future<void> editBreed(String petId, String type, String oldBreed, String newBreed, String gender) async {
    try {
      await _petRepository.editPetBreed(
          petId: petId, type: type, oldBreed: oldBreed, newBreed: newBreed, gender: gender);
    } on Object {
      rethrow;
    }
  }
}
