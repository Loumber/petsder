import 'package:auto_route/auto_route.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:elementary/elementary.dart';
import 'package:petsder/common/utils/di/scopes/global/global_scope.dart';
import 'package:petsder/common/utils/di/scopes/user_info/user_info_scope.dart';
import 'package:petsder/common/utils/extensions/widget_model_extensions.dart';
import 'package:petsder/data/models/pet/pet_response.dart';
import 'package:petsder/ui/features/edit_pet/edit_pet_model.dart';
import 'package:petsder/ui/features/edit_pet/edit_pet_widget.dart';
import 'package:petsder/ui/features/edit_pet/widgets/edit_name.dart';
import 'package:petsder/ui/theme/theme.dart';

abstract interface class IEditPetWidgetModel implements IWidgetModel {
  
  EntityValueListenable<PetResponse?> get currentPetListinable;

  void onBackTap();

  void onPhotosEditTap();

  void onNameEditTap();

  ScrollController get scrollController;

  AppThemeData get theme;

  MediaQueryData get mediaQuaery;
}

EditPetWidgetModel defaultEditPetWidgetModelFactory(BuildContext context) {
  return EditPetWidgetModel(EditPetModel(context.user.userController, context.global.petRepository, context.global.overlayBloc));
}

class EditPetWidgetModel extends WidgetModel<EditPetScreen, IEditPetModel> implements IEditPetWidgetModel {
  EditPetWidgetModel(EditPetModel super.model);

  final _currentPetEntity = EntityStateNotifier<PetResponse?>();

  final TextEditingController editNameController = TextEditingController();

  @override
  EntityValueListenable<PetResponse?> get currentPetListinable => _currentPetEntity;

  final _scrollController = ScrollController();

  @override
  ScrollController get scrollController => _scrollController;

  @override
  Future<void> onBackTap() async {
    await context.router.maybePop();
  }

  @override
  void onPhotosEditTap() {
    // TODO: implement onPhotosEditTap
  }

  Future<void> onNameSaveTap() async {
    try{
      await model.editName(editNameController.text);
      // ignore: use_build_context_synchronously
      context.router.maybePop();

      _currentPetEntity.loading();
      
      final res = model.getCurrentPet();

      _currentPetEntity.content(res);
    } on Object {
      model.showOverlayNotification(const Text('Не удалось обновить имя'));
    }
  }

  @override
  Future<void> onNameEditTap() async {
    await showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context){
        return EditNameBottomSheet(
          controller: editNameController,
          onSaveTap: onNameSaveTap,
        );
      }
    );
  }

  @override
  void initWidgetModel() {
    _initAsync();

    super.initWidgetModel();
  }

  Future<void> _initAsync() async {
    try {
      _currentPetEntity.loading();
      
      final res = model.getCurrentPet();

      _currentPetEntity.content(res);

      
    } on Exception {
      _currentPetEntity.error();
    }
  }

  @override
  MediaQueryData get mediaQuaery => wmMediaQuery;

  @override
  AppThemeData get theme => wmTheme;
}
