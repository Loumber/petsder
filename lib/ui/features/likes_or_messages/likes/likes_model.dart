import 'package:elementary/elementary.dart';
import 'package:petsder/data/models/pet/pet_response.dart';
import 'package:petsder/domain/pet/pet_repository.dart';
abstract interface class ILikesModel extends ElementaryModel{
  Future<List<PetResponse>> getLikesPet();
}

class LikesModel extends ILikesModel {

  LikesModel(this._petRepository);


  final PetRepository _petRepository;


  @override
  Future<List<PetResponse>> getLikesPet() {
    try{
      return _petRepository.getLikesPet();
    }on Object{
      rethrow;
    }
  }


}