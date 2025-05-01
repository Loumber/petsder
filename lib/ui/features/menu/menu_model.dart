import 'package:elementary/elementary.dart';
import 'package:petsder/data/models/pet/pet_response.dart';
import 'package:petsder/domain/pet/pet_repository.dart';
abstract interface class IMenuScreenModel extends ElementaryModel{

  Future<List<PetResponse>> getPotentioalMatches();

}

class MenuScreenModel extends IMenuScreenModel {

  MenuScreenModel(this._petRepository);


  final PetRepository _petRepository;

  @override
  Future<List<PetResponse>> getPotentioalMatches() async {
    try {
      final res = await _petRepository.findPotentialMatches();
      res.add(res.first);
      return res;
    } on Object  {
      rethrow;
    }


  }
}