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
import 'package:petsder/ui/features/account/wigets/change_password_bottom_sheet.dart';

import '../../theme/theme.dart';
import 'account_model.dart';

abstract interface class IAccountWidgetModel implements IWidgetModel {
  EntityValueListenable<List<PetResponse>> get petsListenable;

  ValueNotifier<PetResponse?> get currentPetListinable;

  Future<void> onAddNewPetTap();

  Future<void> onSignOutTap();

  Future<void> onChangePasswordTap();
  
  bool isCurrent(int index);

  ScrollController get scrollController;

  AppThemeData get theme;

  MediaQueryData get mediaQuaery;
}

AccountWidgetModel defaultAccountWidgetModelFactory(BuildContext context) {
  return AccountWidgetModel(AccountModel(context.global.petRepository, context.user.userController, context.global.overlayBloc));
}

class AccountWidgetModel extends WidgetModel<AccountScreen, IAccountModel> implements IAccountWidgetModel {
  AccountWidgetModel(AccountModel super.model);

  @override
  MediaQueryData get mediaQuaery => wmMediaQuery;

  @override
  AppThemeData get theme => wmTheme;

  final _currentPetEntity = ValueNotifier<PetResponse?>(null);

  @override
  ValueNotifier<PetResponse?> get currentPetListinable => _currentPetEntity;

  final _petsEntity = EntityStateNotifier<List<PetResponse>>();

  @override
  EntityValueListenable<List<PetResponse>> get petsListenable => _petsEntity;

  final _scrollController = ScrollController();

  final TextEditingController changePasswordController = TextEditingController();

  @override
  ScrollController get scrollController => _scrollController;

  @override
  void initWidgetModel() {
    _initAsync();

    super.initWidgetModel();
  }

  Future<void> _initAsync() async {
    try {
      _petsEntity.loading();
      
      final res = await model.getPets();

      final currentPet = model.getCurrentPet();

      _currentPetEntity.value = currentPet;

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
    await model.signOut();
  }

  Future<void> onSaveTap() async {
    try{
      model.changePassword(changePasswordController.text);
    } on Object {
      model.showOverlayNotification(const Text('Не удалось обновить пароль'));
    }
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
          onSaveTap: onSaveTap,
        );
      }
    );
  }

  
}
