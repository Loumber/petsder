import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypton/crypton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petsder/common/utils/di/scopes/global/global_scope.dart';
import 'package:petsder/data/models/editable_photo/editable_photo.dart';
import 'package:petsder/data/models/pet/pet_response.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PetRepository {
  final _currentPetNotifier = ValueNotifier<PetResponse?>(null);

  ValueNotifier<PetResponse?> get currentPetNotifier => _currentPetNotifier;

  Future<void> changeCurrentPet(String id) async {
    try {
      if (FirebaseAuth.instance.currentUser == null) return;
    final user = FirebaseAuth.instance.currentUser!.uid;
      final firestore = FirebaseFirestore.instance;
      await firestore.collection('users').doc(user).update({
      'pets': FieldValue.arrayUnion([id]),
      'currentPet': id,
    });
    } on Object {
      rethrow;
    }
  }

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
      String description, String geohash, BuildContext context) async {
    if (FirebaseAuth.instance.currentUser == null) return;

    final rsaKeypair = RSAKeypair.fromRandom();

    final privateKey = rsaKeypair.privateKey;
    final publicKey = rsaKeypair.publicKey;

    final user = FirebaseAuth.instance.currentUser!.uid;
    final pId = '${user}_$name';

    context.global.secureStorage.write(key: '${pId}_private', value: privateKey.toPEM());

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
      'privateKey': privateKey.toPEM(),
      'publicKey': publicKey.toPEM(),
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
    try {
      final user = FirebaseAuth.instance.currentUser;
      final pet = _currentPetNotifier.value;
      if (user == null || pet == null) return;
      final petRef = FirebaseFirestore
        .instance.collection('pets')
        .doc(pet.id);
      await petRef.update({'name': name});
    } on Object {
      rethrow;
    }
  }

  Future<void> editBirth(String birth) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final pet = _currentPetNotifier.value;

      if (user == null || pet == null) return;

      final petRef = FirebaseFirestore.instance.collection('pets').doc(pet.id);

      await petRef.update({'age': birth});
    } on Object {
      rethrow;
    }
  }

  Future<void> editPetType({
    required String petId,
    required String oldType,
    required String oldBreed,
    required String gender,
    required String newType,
  }) async {
    final firestore = FirebaseFirestore.instance;

    final oldDocRef =
        firestore.collection('finder').doc(oldType).collection(oldBreed).doc(gender).collection('pets').doc(petId);

    final oldSnapshot = await oldDocRef.get();
    if (!oldSnapshot.exists) return;

    final oldData = oldSnapshot.data();
    if (oldData == null) return;

    final newDocRef =
        firestore.collection('finder').doc(newType).collection(oldBreed).doc(gender).collection('pets').doc(petId);

    await newDocRef.set(oldData);

    await oldDocRef.delete();

    await firestore.collection('pets').doc(petId).update({
      'type': newType,
    });
  }

  Future<void> editPetGender({
    required String petId,
    required String type,
    required String oldBreed,
    required String oldGender,
    required String newGender,
  }) async {
    final firestore = FirebaseFirestore.instance;

    final oldDocRef =
        firestore.collection('finder').doc(type).collection(oldBreed).doc(oldGender).collection('pets').doc(petId);

    final oldSnapshot = await oldDocRef.get();
    if (!oldSnapshot.exists) return;

    final oldData = oldSnapshot.data();
    if (oldData == null) return;

    final newDocRef =
        firestore.collection('finder').doc(type).collection(oldBreed).doc(newGender).collection('pets').doc(petId);

    await newDocRef.set(oldData);

    await oldDocRef.delete();

    await firestore.collection('pets').doc(petId).update({
      'gender': newGender,
    });
  }

  Future<void> editPetBreed({
    required String petId,
    required String type,
    required String oldBreed,
    required String newBreed,
    required String gender,
  }) async {
    final firestore = FirebaseFirestore.instance;

    final oldDocRef =
        firestore.collection('finder').doc(type).collection(oldBreed).doc(gender).collection('pets').doc(petId);

    final oldSnapshot = await oldDocRef.get();
    if (!oldSnapshot.exists) return;

    final oldData = oldSnapshot.data();
    if (oldData == null) return;

    final newDocRef =
        firestore.collection('finder').doc(type).collection(newBreed).doc(gender).collection('pets').doc(petId);

    await newDocRef.set(oldData);

    await oldDocRef.delete();

    await firestore.collection('pets').doc(petId).update({
      'breed': newBreed,
    });
  }

  Future<void> updatePetPhotos({
    required String petId,
    required List<EditablePhoto?> updatedPhotos,
  }) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      final supabase = Supabase.instance.client;
      final uid = user.uid;
      final path = 'users/$uid/pets/$petId/';

      final existingFiles = await supabase.storage.from('images').list(path: path);
      final existingUrls =
          existingFiles.map((f) => supabase.storage.from('images').getPublicUrl('$path${f.name}')).toList();

      final updatedUrls = updatedPhotos.where((photo) => photo?.url != null).map((photo) => photo!.url!).toList();

      final toDelete = existingUrls.where((url) => !updatedUrls.contains(url)).toList();
      for (final url in toDelete) {
        final filename = url.split('/').last;
        await supabase.storage.from('images').remove(['$path$filename']);
      }

      final List<String> finalUrls = [...updatedUrls];
      final timestamp = DateTime.now().millisecondsSinceEpoch;

      for (final photo in updatedPhotos) {
        if (photo?.file != null) {
          final file = File(photo!.file!.path);
          final filename = '${timestamp}_${photo.hashCode}';
          final fullPath = '$path$filename';

          await supabase.storage.from('images').upload(fullPath, file);

          final publicUrl = supabase.storage.from('images').getPublicUrl(fullPath);
          finalUrls.add(publicUrl);
        }
      }

      await FirebaseFirestore.instance.collection('pets').doc(petId).update({
        'photos': finalUrls,
      });
    } on Object {
      rethrow;
    }
  }

  Future<void> editDescriptionName(String description) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final pet = _currentPetNotifier.value;

      if (user == null || pet == null) return;

      final petRef = FirebaseFirestore.instance.collection('pets').doc(pet.id);

      await petRef.update({'description': description});
    } on Object {
      rethrow;
    }
  }

  Future<List<PetResponse>> findPotentialMatches(double areasRadius) async {
    final firestore = FirebaseFirestore.instance;

    try {
      if (_currentPetNotifier.value == null) return [];
      final currentPet = _currentPetNotifier.value!;
      final prefix = currentPet.geohash.substring(0, areasRadius.round());

      final likesSnapshot = await firestore.collection('pets').doc(currentPet.id).collection('likes').get();

      final likedPetIds = likesSnapshot.docs.map((doc) => doc.id).toSet();

      final snapshot = await firestore
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

        if (likedPetIds.contains(petId)) return null;

        final fullPetDoc = await firestore.collection('pets').doc(petId).get();
        if (fullPetDoc.exists) {
          return PetResponse.fromJson(fullPetDoc.data()!);
        } else {
          return null;
        }
      }));

      return petDocs.whereType<PetResponse>().where((p) => p.ownerId != currentPet.ownerId).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> likePet(String likedPetId, String fromPetId) async {
    try {
      final firestore = FirebaseFirestore.instance;

      await firestore.collection('likes').doc(likedPetId).collection('from').doc(fromPetId).set({
        'timestamp': FieldValue.serverTimestamp(),
        'fromPetId': fromPetId,
        'displayed': true,
      });

      await firestore.collection('pets').doc(fromPetId).collection('likes').doc(likedPetId).set({
        'timestamp': FieldValue.serverTimestamp(),
      });

      final mutualLikeDoc = await firestore.collection('likes').doc(fromPetId).collection('from').doc(likedPetId).get();

      if (mutualLikeDoc.exists) {
        await firestore
            .collection('likes')
            .doc(likedPetId)
            .collection('from')
            .doc(fromPetId)
            .update({'displayed': false});
        await firestore
            .collection('likes')
            .doc(fromPetId)
            .collection('from')
            .doc(likedPetId)
            .update({'displayed': false});

        final chatId = [fromPetId, likedPetId]..sort();
        final chatDocId = chatId.join('_');

        final chatRef = firestore.collection('chats').doc(chatDocId);

        final chatSnapshot = await chatRef.get();
        if (!chatSnapshot.exists) {
          await chatRef.set({
            'participants': [fromPetId, likedPetId],
            'createdAt': FieldValue.serverTimestamp(),
            'lastMessage': null,
            'lastMessageTime': null
          });

          final batch = firestore.batch();

          final fromChatRef = firestore.collection('pets').doc(fromPetId).collection('chats').doc(chatDocId);
          final likedChatRef = firestore.collection('pets').doc(likedPetId).collection('chats').doc(chatDocId);

          batch.set(fromChatRef, {
            'chatId': chatDocId,
            'withPetId': likedPetId,
            'createdAt': FieldValue.serverTimestamp(),
            'lastMessage': null,
            'lastMessageTime': null
          });

          batch.set(likedChatRef, {
            'chatId': chatDocId,
            'withPetId': fromPetId,
            'createdAt': FieldValue.serverTimestamp(),
            'lastMessage': null,
            'lastMessageTime': null
          });

          await batch.commit();
        }
      }
    } on Object {
      rethrow;
    }
  }

  Future<List<PetResponse>> getLikesPet() async {
    try {
      final firestore = FirebaseFirestore.instance;
      final currentPet = _currentPetNotifier.value;

      if (currentPet == null) return [];

      final likesSnapshot = await firestore
          .collection('likes')
          .doc(currentPet.id)
          .collection('from')
          .where('displayed', isEqualTo: true)
          .get();

      final likedByIds = likesSnapshot.docs.map((doc) => doc.id).toList();

      if (likedByIds.isEmpty) return [];

      final petsQuerySnapshot =
          await firestore.collection('pets').where(FieldPath.documentId, whereIn: likedByIds).get();

      final pets = petsQuerySnapshot.docs.map((doc) => PetResponse.fromJson(doc.data())).toList();

      return pets;
    } catch (e) {
      rethrow;
    }
  }
}
