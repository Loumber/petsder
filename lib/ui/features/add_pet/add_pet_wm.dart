import 'package:auto_route/auto_route.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:elementary/elementary.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petsder/common/utils/di/app_async_dependency.dart';
import 'package:petsder/common/utils/di/scopes/global/global_scope.dart';
import 'package:petsder/common/utils/di/wrappers/user_scope_wrapper.dart';
import 'package:petsder/common/utils/extensions/widget_model_extensions.dart';
import 'package:petsder/common/utils/logger/logger.dart';
import 'package:petsder/common/utils/navigation/app_router.dart';
import 'package:petsder/data/models/animal/animal_response.dart';
import 'package:petsder/data/models/enums/add_pet_state.dart';
import 'package:petsder/ui/features/auth/login/login_wm.dart';

import '../../theme/theme.dart';
import 'add_pet_model.dart';
import 'add_pet_widget.dart';

abstract interface class IAddPetWidgetModel implements IWidgetModel {

  ValueNotifier<AddPetState> get stateListenable;
  
  ValueNotifier<EntityState<List<AnimalResponse>>> get animalsListenable;

  ValueNotifier<EntityState<String>> get genderListenable;

  ValueNotifier<EntityState<List<XFile?>>> get photosListenable;

  TextEditingController get nameController;

  TextEditingController get ageController;

  TextEditingController get typeController;

  TextEditingController get breedController;

  TextEditingController get additionalInfoController;

  Future<void> onAddPetPressed();

  Future<void> onAgePetTap();

  Future<void> onSaveInfoTap();

  void onSavePhotosPressed();

  List<AnimalResponse> filterAnimals(String pattern);

  List<String> filterBreeds(String pattern);
  
  void onAnimalSelected(AnimalResponse selectedAnimal);

  void onAnimalBreedSelected(String selectedBreed);

  void onGenderSelected(String? selectedGender);

  void onMainTap();

  void onPhotosTap();

  void onPhotoTap(int index);

  AppThemeData get theme;
  
  MediaQueryData get mediaQuaery;
}

AddPetWidgetModel defaultAddPetWidgetModelFactory(BuildContext context) {
  return AddPetWidgetModel(AddPetModel(
    context.global.animalRepository,
    context.global.petRepository,
    context.global.overlayBloc,
  ));
}

class AddPetWidgetModel extends WidgetModel<AddPetScreen, IAddPetModel>
    implements IAddPetWidgetModel {
  AddPetWidgetModel(AddPetModel super.model);

  final _stateEntity = ValueNotifier<AddPetState>(AddPetState.main);

  @override
  ValueNotifier<AddPetState> get stateListenable => _stateEntity;

  final _photosEntity = ValueNotifier<EntityState<List<XFile?>>>(EntityState<List<XFile?>>.content([null,null,null,null,null,null,null,null,null]));

  @override
  ValueNotifier<EntityState<List<XFile?>>> get photosListenable => _photosEntity;

  final _animalsEntity = EntityStateNotifier<List<AnimalResponse>>();

  String? type; 
  
  @override
  ValueNotifier<EntityState<List<AnimalResponse>>> get animalsListenable => _animalsEntity;

  final _genderEntity = EntityStateNotifier<String>();

  @override
  ValueNotifier<EntityState<String>> get genderListenable => _genderEntity;


  final _nameController = TextEditingController();

  @override
  TextEditingController get nameController => _nameController;

  final _ageController = TextEditingController();

  @override
  TextEditingController get ageController => _ageController;

  final _typeController = TextEditingController();

  @override
  TextEditingController get typeController => _typeController;

  final _breedController = TextEditingController();

  @override
  TextEditingController get breedController => _breedController;

  final _additionalInfoController = TextEditingController();

  @override
  TextEditingController get additionalInfoController => _additionalInfoController;

  Future<void> _loadAnimals() async {  
    _animalsEntity.loading();
    try {
      final animals = await model.getAnimals();
      _animalsEntity.content(animals);
      AppLogger.info(_animalsEntity.value.data!);
    } on Object {
      model.showOverlayNotification(const Text('Не удалось загрузить необходимые данные'));
    }
    
  }

  @override
  void initWidgetModel() {
    _initAsync();

    
    super.initWidgetModel();
  }

  Future<void> _initAsync() async {
    await Future.wait([
      _loadAnimals(),
    ]);
  }

  @override
  Future<void> onAddPetPressed() async {
    _animalsEntity.loading(); 
    if(_ageController.text.isEmpty || _nameController.text.isEmpty || _typeController.text.isEmpty || _breedController.text.isEmpty || _genderEntity.value.data == null) {
      model.showOverlayNotification(const Text('Не удалось зарегистрироваться'));
      await Future.wait([
        _loadAnimals(),
      ]);
      return;
    }

    _stateEntity.value = AddPetState.photo;

  }

  @override
  Future<void> onSaveInfoTap() async {
    _animalsEntity.loading();

    try {
      await model.addPet(
      nameController.text,
      ageController.text,
      typeController.text,
      breedController.text,
      _genderEntity.value.data!,
      photosListenable.value.data!,
      additionalInfoController.text
    );

    // ignore: use_build_context_synchronously
    context.router.push(const MenuRoute());
    } on Object {
      model.showOverlayNotification(const Text('Не удалось отправить данные о питомце'));
    }
    
  }

  @override
  Future<void> onAgePetTap() async {
      DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      ageController.text = "${pickedDate.day}.${pickedDate.month}.${pickedDate.year}";
    }
  }

  @override 
  void onSavePhotosPressed(){
    _stateEntity.value = AddPetState.additional;
  }

  @override
  List<AnimalResponse> filterAnimals(String pattern) {
    return _animalsEntity.value.data?.where((animal) {
      return animal.type.toLowerCase().contains(pattern.toLowerCase());
    }).toList() ?? [];
  }

  @override
  List<String> filterBreeds(String pattern) {
    if (type == null) return [];
    return _animalsEntity.value.data?.where((animal) {
      return animal.type == type;
      }).first.breed.where((breed) {
        return breed.toLowerCase().contains(pattern.toLowerCase());
    }).toList() ?? [];
  }

  @override
  void onGenderSelected(String? selectedGender) {
    if(selectedGender == null) return;
    _genderEntity.content(selectedGender);

  }

  @override
  void onAnimalSelected(AnimalResponse selectedAnimal) {
    type = selectedAnimal.type;
    typeController.text = selectedAnimal.type;
    breedController.clear();
  }

  @override
  void onAnimalBreedSelected(String selectedBreed) {
    breedController.text = selectedBreed;
  }

  @override
  Future<void> onMainTap() async {
    await Future.wait([
      _loadAnimals(),
    ]);
    
    _stateEntity.value = AddPetState.main;
  }

  @override
  Future<void> onPhotoTap(int index) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    final currentPhotos = _photosEntity.value.data;
    if(currentPhotos == null) return;
    currentPhotos[index] = image;


    _photosEntity.value = EntityState<List<XFile?>>.content(currentPhotos);
  }

  @override
  void onPhotosTap() {
    _stateEntity.value = AddPetState.photo;
  }

  @override
  MediaQueryData get mediaQuaery => wmMediaQuery;

  @override
  AppThemeData get theme => wmTheme;
}