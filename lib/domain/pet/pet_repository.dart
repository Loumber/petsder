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

  Future<void> addPet(
    String name,
    String age,
    String type,
    String breed,
    String gender,
    List<String> photos,
    String description,
  ) async {
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
    };

    final firestore = FirebaseFirestore.instance;

    await firestore.collection('pets').doc(pId).set(petData);

    await firestore
        .collection('finder')
        .doc(type)
        .collection(breed)
        .doc(gender)
        .collection('pets')
        .doc(pId)
        .set({'id': pId});
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
}
