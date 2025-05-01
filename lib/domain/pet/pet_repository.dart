import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petsder/data/models/pet/pet_response.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PetRepository {
  final _currentPetNotifier = ValueNotifier<PetResponse?>(null);

  ValueNotifier<PetResponse?> get currentPetNotifier => _currentPetNotifier;

  Future<void> uploadPhotos(String petId, List<XFile?> photos) async {
    if (FirebaseAuth.instance.currentUser == null) return;
    final user = FirebaseAuth.instance.currentUser!.uid;
    final pId = '${user}_$petId';
    for (XFile? photo in photos) {
      if (photo != null) {
        final file = File(photo.path);
        final fileName = DateTime.now().millisecondsSinceEpoch.toString();
        final path = 'users/$user/pets/$pId/$fileName';

        await Supabase.instance.client.storage.from('images').upload(path, file);
      }
    }
  }

  Future<List<String>> getPetPhotos(String petId) async {
    if (FirebaseAuth.instance.currentUser == null) return [];
    final supabase = Supabase.instance.client;
    final user = FirebaseAuth.instance.currentUser!.uid;
    final pId = '${user}_$petId';
    final path = 'users/$user/pets/$pId/';

    final response = await supabase.storage.from('images').list(path: path);

    if (response.isEmpty) return [];

    List<String> photoUrls = response.map((file) {
      return supabase.storage.from('images').getPublicUrl('$path${file.name}');
    }).toList();

    return photoUrls;
  }

  Future<void> getCurrentPet() async {
    try {
      if (FirebaseAuth.instance.currentUser == null) return;

      final user = FirebaseAuth.instance.currentUser!.uid;

      final firestore = FirebaseFirestore.instance;

      final userDoc = await firestore.collection('users').doc(user).get();

      final petDoc = await firestore.collection('pets').doc(userDoc['currentPet'] as String).get();

      if (petDoc.exists) {
        final petData = petDoc.data()!;
        final pet = PetResponse.fromJson(petData);

        _currentPetNotifier.value = pet;
      }
    } on Object {
      rethrow;
    }
  }

  Future<void> setGeoHashForCurrentPet(String geohash) async {
    if (FirebaseAuth.instance.currentUser == null) return;

    try {
      final user = FirebaseAuth.instance.currentUser!.uid;

      final firestore = FirebaseFirestore.instance;

      final userDoc = await firestore.collection('users').doc(user).get();

      if (userDoc.exists) {
        final petId = userDoc['currentPet'];
        final petDoc = await firestore.collection('pets').doc(petId).get();

        if (petDoc.exists) {
          await firestore.collection('pets').doc(petId).update({
            'geohash': geohash,
          });
        }
      }
    } on Object {
      rethrow;
    }
  }

  Future<void> addPet(String name, String age, String type, String breed, String gender, List<String> photos,
      String description, String geohash) async {
    if (FirebaseAuth.instance.currentUser == null) return;

    final user = FirebaseAuth.instance.currentUser!.uid;
    final pId = '${user}_$name';

    final petData = {
      'id': pId,
      'ownerId': user,
      'name': name,
      'age': age,
      'type': type,
      'breed': breed,
      'gender': gender,
      'photos': photos,
      'description': description,
      'geohash': geohash,
    };

    final firestore = FirebaseFirestore.instance;

    await firestore.collection('pets').doc(pId).set(petData);

    await firestore.collection('finder').doc(type).collection(breed).doc(gender).collection('pets').doc(pId).set({
      'id': pId,
      'geohash': geohash,
    });
    await firestore.collection('users').doc(user).update({
      'pets': FieldValue.arrayUnion([pId]),
      'currentPet': pId,
    });
  }

  Future<List<String>> getPetsForUser(String user, FirebaseFirestore firestore) async {
    final userDoc = await firestore.collection('users').doc(user).get();

    if (userDoc.exists) {
      List<dynamic> pets = userDoc.data()?['pets'] ?? [];

      List<String> petIds = pets.map((pet) => pet as String).toList();

      return petIds;
    } else {
      return [];
    }
  }

  Future<List<PetResponse>> getPets() async {
    if (FirebaseAuth.instance.currentUser == null) throw Exception();

    final user = FirebaseAuth.instance.currentUser!.uid;
    final firestore = FirebaseFirestore.instance;

    final List<PetResponse> pets = [];
    try {
      final pId = await getPetsForUser(user, firestore);

      for (String pId in pId) {
        final petDoc = await firestore.collection('pets').doc(pId).get();

        if (petDoc.exists) {
          final petData = petDoc.data()!;
          final pet = PetResponse.fromJson(petData);

          pets.add(pet);
        }
      }
    } on Object catch (e, stackTrace) {
      Error.throwWithStackTrace(e, stackTrace);
    }
    return pets;
  }

  Future<void> editPetName(String name) async {
    if (FirebaseAuth.instance.currentUser == null) return;

    if (_currentPetNotifier.value == null) return;
    final pId = _currentPetNotifier.value!.id;

    final petRef = await FirebaseFirestore.instance.collection('pets').doc(pId);

    await petRef.update({'name': name});
  }

  Future<List<PetResponse>> findPotentialMatches() async {
    final firestore = FirebaseFirestore.instance;
    try {
      if (_currentPetNotifier.value == null) return [];
      final currentPet = _currentPetNotifier.value!;

      final prefix = currentPet.geohash.substring(0, 5);

      final snapshot = await FirebaseFirestore.instance
          .collection('finder')
          .doc(currentPet.type)
          .collection(currentPet.breed)
          .doc(currentPet.gender == 'Самец' ? 'Самка' : 'Самец')
          .collection('pets')
          .where('geohash', isGreaterThanOrEqualTo: prefix)
          .where('geohash', isLessThan: '$prefix~')
          .get();

      final petDocs = await Future.wait(snapshot.docs.map((doc) async {
        final petId = doc.id;
        final fullPetDoc = await firestore.collection('pets').doc(petId).get();
        if (fullPetDoc.exists) {
          return PetResponse.fromJson(fullPetDoc.data()!);
        } else {
          return null;
        }
      }));

      return  petDocs.whereType<PetResponse>().where((p) => p.ownerId != currentPet.ownerId).toList();
    } on Object {
      rethrow;
    }
  }
}
