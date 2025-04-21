import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petsder/data/models/animal/animal_response.dart';


class AnimalRepository {

  Future<List<AnimalResponse>> allAniamls() async {
    try {
      final animalSnapshot = await FirebaseFirestore.instance.collection('animals').get();
      return animalSnapshot.docs.map((e) => AnimalResponse.fromJson(e.data())).toList();
    } on Object catch (e, stackTrace) {
      Error.throwWithStackTrace(e, stackTrace);
    }
  }

  
}