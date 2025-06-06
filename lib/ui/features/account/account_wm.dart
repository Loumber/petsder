import 'package:auto_route/auto_route.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:elementary/elementary.dart';
import 'package:petsder/common/utils/di/scopes/global/global_scope.dart';
import 'package:petsder/common/utils/di/scopes/user_info/user_info_scope.dart';
import 'package:petsder/common/utils/extensions/widget_model_extensions.dart';
import 'package:petsder/common/utils/navigation/app_router.dart';
import 'package:petsder/data/models/pet/pet_response.dart';
import 'package:petsder/ui/features/account/account_widget.dart';
import 'package:petsder/ui/features/account/wigets/change_email_bottom_sheet.dart';
import 'package:petsder/ui/features/account/wigets/change_password_bottom_sheet.dart';

import '../../theme/theme.dart';
import 'account_model.dart';

abstract interface class IAccountWidgetModel implements IWidgetModel {
  EntityValueListenable<List<PetResponse>> get petsListenable;

  ValueNotifier<PetResponse?> get currentPetListinable;

  ValueNotifier<double> get searchAreaListinable;

  Future<void> onAnotherPetTap(String petId);

  Future<void> onAddNewPetTap();

  Future<void> onSignOutTap();

  Future<void> onChangeEmailTap();

  Future<void> onChangePasswordTap();

  void onEditPetTap();
  
  bool isCurrent(int index);

  ScrollController get scrollController;

  AppThemeData get theme;

  MediaQueryData get mediaQuaery;
}

AccountWidgetModel defaultAccountWidgetModelFactory(BuildContext context) {
  return AccountWidgetModel(AccountModel(context.user.petRepository, context.user.userController, context.global.overlayBloc));
}

class AccountWidgetModel extends WidgetModel<AccountScreen, IAccountModel> implements IAccountWidgetModel {
  AccountWidgetModel(AccountModel super.model);

  @override
  MediaQueryData get mediaQuaery => wmMediaQuery;

  @override
  AppThemeData get theme => wmTheme;

  late final ValueNotifier<PetResponse?> _currentPetEntity;

  @override
  ValueNotifier<PetResponse?> get currentPetListinable => _currentPetEntity;


  // ignore: prefer_typing_uninitialized_variables
  late final _searchAreaEntity;

  @override
  ValueNotifier<double> get searchAreaListinable => _searchAreaEntity;

  final _petsEntity = EntityStateNotifier<List<PetResponse>>();

  @override
  EntityValueListenable<List<PetResponse>> get petsListenable => _petsEntity;

  final _scrollController = ScrollController();

  final TextEditingController changeEmailController = TextEditingController();

  final TextEditingController changePasswordController = TextEditingController();

  @override
  ScrollController get scrollController => _scrollController;

  @override
  void initWidgetModel() {

    _searchAreaEntity = context.user.userController.radiusOfSearchAreaNotifier;

    _currentPetEntity = context.user.userController.currentPetNotifier;

    _initAsync();

    super.initWidgetModel();
  }

  @override
  Future<void> onAnotherPetTap(String petId)async {
    try {
      if(_currentPetEntity.value != null && petId == _currentPetEntity.value!.id) return;
      await   model.changeCurrentPet(petId);
      // ignore: use_build_context_synchronously
      context.user.updateCurrentPet();
    } on Exception {
      _petsEntity.error();
    }

  }

  Future<void> _initAsync() async {
    try {
      _petsEntity.loading();
      
      final res = await model.getPets();

      _petsEntity.content(res);
    } on Exception {
      _petsEntity.error();
    }
  }

  @override
  bool isCurrent(int index) {
    if(_petsEntity.value.data == null || _currentPetEntity.value == null) return false;
    
    final pet = _petsEntity.value.data![index];

    return pet == _currentPetEntity.value!;
  }

  @override
  Future<void> onAddNewPetTap() async {
    context.router.push(const AddPetRoute()) ;
  }

  @override
  Future<void> onSignOutTap() async {
    context.router.push(const AuthRoute());
    await model.signOut();    
  }

  Future<void> onSaveEmailTap() async {
    try{
      model.changeEmail(changeEmailController.text);
      Navigator.pop(context);
      model.showOverlaySuccessNotification('Почта успешно изменена');
    } on Object {
      model.showOverlayNotification(const Text('Не удалось обновить почту'));
    }
  }

  Future<void> onSavePasswordTap() async {
    try{
      model.changePassword(changePasswordController.text);
      Navigator.pop(context);
      model.showOverlaySuccessNotification('Пароль успешно изменен');
    } on Object {
      model.showOverlayNotification(const Text('Не удалось обновить пароль'));
    }
  }

  @override
  Future<void> onChangeEmailTap() async {
    await showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context){
        return ChangeEmailBottomSheet(
          controller: changeEmailController,
          onSaveTap: onSavePasswordTap,
        );
      }
    );
    changeEmailController.clear();
  }

  @override
  Future<void> onChangePasswordTap() async {
    await showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context){
        return ChangePasswordBottomSheet(
          controller: changePasswordController,
          onSaveTap: onSavePasswordTap,
        );
      }
    );
    changePasswordController.clear();
  }

  @override 
  Future<void> onEditPetTap() async {
    await context.router.push(const EditPetRoute());
    // ignore: use_build_context_synchronously
    await context.user.updateCurrentPet();

    final currentPet = model.getCurrentPet();
    final res = await model.getPets();

    _currentPetEntity.value = currentPet;
    _petsEntity.content(res);
  }
}
