import 'package:elementary/elementary.dart';
import 'package:petsder/data/models/pet/pet_response.dart';
import 'package:petsder/domain/pet/pet_repository.dart';
abstract interface class IMenuScreenModel extends ElementaryModel{

  Future<List<PetResponse>> getPotentioalMatches(double areaRadius);

  Future<void> likePet(String likedPetId, String fromPetId);

}

class MenuScreenModel extends IMenuScreenModel {

  MenuScreenModel(this._petRepository);


  final PetRepository _petRepository;

  @override
  Future<List<PetResponse>> getPotentioalMatches(double areaRadius) async {
    try {
      return await _petRepository.findPotentialMatches(areaRadius);
    } on Object  {
      rethrow;
    }
  }


  @override
  Future<void> likePet(String likedPetId, String fromPetId) async {
    try{
      await _petRepository.likePet(likedPetId, fromPetId);
    } on Object {
      rethrow;
    }
    
  }
}