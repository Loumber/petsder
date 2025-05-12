import 'package:auto_route/auto_route.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:elementary/elementary.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petsder/common/utils/di/scopes/global/global_scope.dart';
import 'package:petsder/common/utils/di/scopes/user_info/user_info_scope.dart';
import 'package:petsder/common/utils/extensions/widget_model_extensions.dart';
import 'package:petsder/data/models/animal/animal_response.dart';
import 'package:petsder/data/models/editable_photo/editable_photo.dart';
import 'package:petsder/data/models/pet/pet_response.dart';
import 'package:petsder/ui/features/edit_pet/edit_pet_model.dart';
import 'package:petsder/ui/features/edit_pet/edit_pet_widget.dart';
import 'package:petsder/ui/features/edit_pet/widgets/edit_breed.dart';
import 'package:petsder/ui/features/edit_pet/widgets/edit_description.dart';
import 'package:petsder/ui/features/edit_pet/widgets/edit_gender.dart';
import 'package:petsder/ui/features/edit_pet/widgets/edit_name.dart';
import 'package:petsder/ui/features/edit_pet/widgets/edit_photos.dart';
import 'package:petsder/ui/features/edit_pet/widgets/edit_type.dart';
import 'package:petsder/ui/theme/theme.dart';

abstract interface class IEditPetWidgetModel implements IWidgetModel {
  EntityValueListenable<PetResponse?> get currentPetListinable;

  void onBackTap();

  void onPhotosEditTap();

  void onNameEditTap();

  void onBirthdaEditTap();

  void onTypeEditTap();

  void onBreedEditTap();

  void onGenderEditTap();

  void onDescriptionEditTap();

  ScrollController get scrollController;

  AppThemeData get theme;

  MediaQueryData get mediaQuaery;
}

EditPetWidgetModel defaultEditPetWidgetModelFactory(BuildContext context) {
  return EditPetWidgetModel(
      EditPetModel(context.user.petRepository, context.global.animalRepository, context.global.overlayBloc));
}

class EditPetWidgetModel extends WidgetModel<EditPetScreen, IEditPetModel> implements IEditPetWidgetModel {
  EditPetWidgetModel(EditPetModel super.model);

  final _currentPetEntity = EntityStateNotifier<PetResponse?>();

  final TextEditingController _editNameController = TextEditingController();

  final TextEditingController _editTypeController = TextEditingController();

  final TextEditingController _editDescriptionController = TextEditingController();

  final TextEditingController _breedController = TextEditingController();

  late final List<AnimalResponse> _listAnimals;

  final _photosEntity = ValueNotifier<EntityState<List<EditablePhoto?>>>(
      EntityState<List<EditablePhoto?>>.content([null, null, null, null, null, null, null, null, null]));

  @override
  EntityValueListenable<PetResponse?> get currentPetListinable => _currentPetEntity;

  final _genderEntity = EntityStateNotifier<String>();

  ValueNotifier<EntityState<String>> get genderListenable => _genderEntity;

  final _scrollController = ScrollController();

  @override
  ScrollController get scrollController => _scrollController;

  @override
  Future<void> onBackTap() async {
    await context.router.maybePop();
  }

  Future<void> _onPhotoTap(int index) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    final currentPhotos = _photosEntity.value.data;
    if (currentPhotos == null) return;
    currentPhotos[index] = EditablePhoto(file: image);

    _photosEntity.value = EntityState<List<EditablePhoto?>>.content(currentPhotos);
  }

  Future<void> onPhotosEditSaveTap() async {
    try {

      final currPet = context.user.userController.currentPetNotifier.value!;
      
      _currentPetEntity.loading();

      await model.editPhotos(currPet.id,currPet.photos ,_photosEntity.value.data!);
      // ignore: use_build_context_synchronously
      await context.router.maybePop();

      // ignore: use_build_context_synchronously
      await context.user.updateCurrentPet();

      // ignore: use_build_context_synchronously
      final res = context.user.userController.currentPetNotifier.value;

      _currentPetEntity.content(res);

    } on Object {
      model.showOverlayNotification(const Text('Не удалось обновить фотографии питомца'));
    }
  }

  @override
  Future<void> onPhotosEditTap() async {
    try {
      await showModalBottomSheet<void>(
          isScrollControlled: true,
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) {
            return FractionallySizedBox(
              heightFactor: 0.9,
              child: EditPhotos(
                photosListenable: _photosEntity,
                onPhotoTap: _onPhotoTap,
                onSavePhotosPressed: onPhotosEditSaveTap,
              ),
            );
          });
      _breedController.clear();
    } on Object {
      model.showOverlayNotification(const Text('Не удалось обновить породу питомца'));
    }
  }

  List<AnimalResponse> _filterAnimals(String pattern) {
    return _listAnimals.where((animal) {
      return animal.type.toLowerCase().contains(pattern.toLowerCase());
    }).toList();
  }

  void _onAnimalSelected(AnimalResponse selectedAnimal) {
    _editTypeController.text = selectedAnimal.type;
  }

  @override
  Future<void> onTypeEditTap() async {
    try {
      await showModalBottomSheet<void>(
          isScrollControlled: true,
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) {
            return FractionallySizedBox(
              heightFactor: 0.9,
              child: EditTypeBottomSheet(
                controller: _editTypeController,
                onSaveTap: _onTypeSaveTap,
                animalList: _filterAnimals,
                onSelected: _onAnimalSelected,
              ),
            );
          });
      _editTypeController.clear();
    } on Object {
      model.showOverlayNotification(const Text('Не удалось обновить вид питомца'));
    }
  }

  void _onAnimalBreedSelected(String selectedBreed) {
    _breedController.text = selectedBreed;
  }

  List<String> _filterBreeds(String pattern) {
    if (currentPetListinable.value.data == null) return [];
    final type = currentPetListinable.value.data!.type;

    return _listAnimals
        .where((animal) {
          return animal.type == type;
        })
        .first
        .breed
        .where((breed) {
          return breed.toLowerCase().contains(pattern.toLowerCase());
        })
        .toList();
  }

  Future<void> _onBreedSaveTap() async {
    try {
      final currPet = context.user.userController.currentPetNotifier.value;
      _currentPetEntity.loading();

      if (currPet == null) throw Exception();

      await model.editBreed(currPet.id, currPet.type, currPet.breed, _breedController.text, currPet.gender);

      // ignore: use_build_context_synchronously
      await context.router.maybePop();

      // ignore: use_build_context_synchronously
      await context.user.updateCurrentPet();

      // ignore: use_build_context_synchronously
      final res = context.user.userController.currentPetNotifier.value;

      _currentPetEntity.content(res);
    } on Object {
      model.showOverlayNotification(const Text('Не удалось обновить породу питомца'));
    }
  }

  @override
  Future<void> onBreedEditTap() async {
    try {
      await showModalBottomSheet<void>(
          isScrollControlled: true,
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) {
            return FractionallySizedBox(
              heightFactor: 0.9,
              child: EditBreedBottomSheet(
                  onSaveTap: _onBreedSaveTap,
                  onSelected: _onAnimalBreedSelected,
                  breedController: _breedController,
                  breedList: _filterBreeds),
            );
          });
      _breedController.clear();
    } on Object {
      model.showOverlayNotification(const Text('Не удалось обновить породу питомца'));
    }
  }

  @override
  Future<void> onBirthdaEditTap() async {
    try {
      DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1990),
        lastDate: DateTime.now(),
      );

      if (pickedDate != null) {
        final birth = "${pickedDate.day}.${pickedDate.month}.${pickedDate.year}";

        _currentPetEntity.loading();

        await model.editBirth(birth);

        // ignore: use_build_context_synchronously
        await context.user.updateCurrentPet();

        // ignore: use_build_context_synchronously
        final res = context.user.userController.currentPetNotifier.value;

        _currentPetEntity.content(res);
      }
    } on Object {
      model.showOverlayNotification(const Text('Не удалось обновить дату рождения'));
    }
  }

  Future<void> _onNameSaveTap() async {
    try {
      _currentPetEntity.loading();

      await model.editName(_editNameController.text);
      // ignore: use_build_context_synchronously
      await context.router.maybePop();

      // ignore: use_build_context_synchronously
      await context.user.updateCurrentPet();

      // ignore: use_build_context_synchronously
      final res = context.user.userController.currentPetNotifier.value;

      _currentPetEntity.content(res);
    } on Object {
      model.showOverlayNotification(const Text('Не удалось обновить имя'));
    }
  }

  Future<void> _onTypeSaveTap() async {
    try {
      final currPet = context.user.userController.currentPetNotifier.value!;
      _currentPetEntity.loading();

      await model.editType(currPet.id, currPet.type, currPet.breed, currPet.gender, _editTypeController.text);
      // ignore: use_build_context_synchronously
      await context.router.maybePop();

      // ignore: use_build_context_synchronously
      await context.user.updateCurrentPet();

      // ignore: use_build_context_synchronously
      final res = context.user.userController.currentPetNotifier.value;

      _currentPetEntity.content(res);
    } on Object {
      model.showOverlayNotification(const Text('Не удалось обновить тип'));
    }
  }

  void onGenderSelected(String? selectedGender) {
    if (selectedGender == null) return;
    _genderEntity.content(selectedGender);
  }

  @override
  Future<void> onGenderEditTap() async {
    try {
      await showModalBottomSheet<void>(
          isScrollControlled: true,
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) {
            return FractionallySizedBox(
              heightFactor: 0.6,
              child: EditGenderBottomSheet(
                onSaveTap: _onGenderSaveTap,
                genderListenable: _genderEntity,
                onGenderSelected: onGenderSelected,
              ),
            );
          });
    } on Object {
      model.showOverlayNotification(const Text('Не удалось обновить тип'));
    }
  }

  Future<void> _onGenderSaveTap() async {
    try {
      final currPet = context.user.userController.currentPetNotifier.value!;
      _currentPetEntity.loading();

      if (_genderEntity.value.data == null) throw Exception();

      await model.editGender(currPet.id, currPet.type, currPet.breed, currPet.gender, _genderEntity.value.data!);
      // ignore: use_build_context_synchronously
      await context.router.maybePop();

      // ignore: use_build_context_synchronously
      await context.user.updateCurrentPet();

      // ignore: use_build_context_synchronously
      final res = context.user.userController.currentPetNotifier.value;

      _currentPetEntity.content(res);
    } on Object {
      model.showOverlayNotification(const Text('Не удалось обновить тип'));
    }
  }

  Future<void> _onDescriptionSaveTap() async {
    try {
      _currentPetEntity.loading();

      await model.editDescription(_editDescriptionController.text);
      // ignore: use_build_context_synchronously
      await context.router.maybePop();

      // ignore: use_build_context_synchronously
      await context.user.updateCurrentPet();

      // ignore: use_build_context_synchronously
      final res = context.user.userController.currentPetNotifier.value;

      _currentPetEntity.content(res);
    } on Object {
      model.showOverlayNotification(const Text('Не удалось обновить описание'));
    }
  }

  @override
  Future<void> onNameEditTap() async {
    await showModalBottomSheet<void>(
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return EditNameBottomSheet(
            controller: _editNameController,
            onSaveTap: _onNameSaveTap,
          );
        });
    _editNameController.clear();
  }

  @override
  Future<void> onDescriptionEditTap() async {
    await showModalBottomSheet<void>(
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return EditDescriptionBottomSheet(
            controller: _editDescriptionController,
            onSaveTap: _onDescriptionSaveTap,
          );
        });
    _editDescriptionController.clear();
  }

  @override
  void initWidgetModel() {
    _initAsync();

    super.initWidgetModel();
  }

  Future<void> _initAsync() async {
    try {
      _currentPetEntity.loading();

      _listAnimals = await model.getAnimals();

      // ignore: use_build_context_synchronously
      final res = context.user.userController.currentPetNotifier.value;

      _currentPetEntity.content(res);

      final initialPhotos = List<EditablePhoto?>.filled(9, null);
      final photosFromServer = res?.photos ?? [];

      for (int i = 0; i < photosFromServer.length && i < initialPhotos.length; i++) {
        initialPhotos[i] = EditablePhoto(url: photosFromServer[i]);
      }

      _photosEntity.value = EntityState<List<EditablePhoto?>>.content(initialPhotos);
    } on Exception {
      _currentPetEntity.error();
    }
  }

  @override
  MediaQueryData get mediaQuaery => wmMediaQuery;

  @override
  AppThemeData get theme => wmTheme;
}
