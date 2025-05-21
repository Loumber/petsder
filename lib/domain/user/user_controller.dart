

import 'package:flutter/foundation.dart';
import 'package:petsder/data/models/pet/pet_response.dart';

class UserController{

  UserController({
    required this.currentPetNotifier,
    required this.radiusOfSearchAreaNotifier
  });

  ValueNotifier<PetResponse?> currentPetNotifier;
  ValueNotifier<double> radiusOfSearchAreaNotifier;
}