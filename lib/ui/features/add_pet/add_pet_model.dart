import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petsder/data/models/animal/animal_response.dart';
import 'package:petsder/domain/animal/animal_repository.dart';
import 'package:petsder/domain/geolocation/geolocation_repository.dart';
import 'package:petsder/domain/overlay_bloc/overlay_bloc.dart';
import 'package:petsder/domain/overlay_bloc/overlay_bloc_events.dart';
import 'package:petsder/domain/pet/pet_repository.dart';
abstract interface class IAddPetModel extends ElementaryModel{

  Future<List<AnimalResponse>> getAnimals();

  Future<void> addPet(String name, String age, String type, String breed, String gender, List<XFile?> photos, String description,BuildContext context);

  void showOverlayNotification(Widget widget);

}

class AddPetModel extends IAddPetModel {

  AddPetModel(
    this._animalRepository,
    this._petRepository,
    this._geolocationRepository,
    this._overlayBloc
  );

  final AnimalRepository _animalRepository;

  final PetRepository _petRepository;

  final GeolocationRepository _geolocationRepository;

  final OverlayBloc _overlayBloc;

  @override
  Future<List<AnimalResponse>> getAnimals() async {
    try{
      final res = await _animalRepository.allAniamls();
      return res;
    } on Object catch (e, stackTrace) {
      Error.throwWithStackTrace(e, stackTrace);
    }
  }
  
  @override 
  void showOverlayNotification(Widget widget)  =>
    _overlayBloc.add(OverlayBlocShowEvent(notificationWidget: widget, duration: const Duration(seconds: 3)));
    

  @override
  Future<void> addPet(String name, String age, String type, String breed, String gender, List<XFile?> photos, String description, BuildContext context) async {
    await _petRepository.uploadPhotos(name, photos);

    final phs = await _petRepository.getPetPhotos(name);

    final positioned = await _geolocationRepository.getCurrentPosition();

    final geohash =  _geolocationRepository.getGeoHash(positioned);

    // ignore: use_build_context_synchronously
    await _petRepository.addPet(name, age, type, breed, gender, phs, description, geohash,context);
  }

}
