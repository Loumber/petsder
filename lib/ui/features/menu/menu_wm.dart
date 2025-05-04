import 'package:auto_route/auto_route.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:petsder/common/utils/di/scopes/user_info/user_info_scope.dart';
import 'package:petsder/common/utils/extensions/widget_model_extensions.dart';
import 'package:petsder/common/utils/logger/logger.dart';
import 'package:petsder/common/utils/navigation/app_router.dart';
import 'package:petsder/data/models/pet/pet_response.dart';
import 'package:petsder/ui/features/menu/menu_model.dart';
import 'package:petsder/ui/features/menu/menu_widget.dart';

import '../../theme/theme.dart';
abstract interface class IMenuScreenWidgetModel implements IWidgetModel {

  EntityValueListenable<List<PetResponse>>  get petsListinable;

  CardSwiperController get cardSwiperController;

  Future<void> onCradTap(int index);

  Future<bool> onSwipe(
    int previousIndex,
    int? currentIndex,
    CardSwiperDirection direction,
  );

  bool onUndo(
    int? previousIndex,
    int currentIndex,
    CardSwiperDirection direction,
  );

  AppThemeData get theme;
  MediaQueryData get mediaQuaery;
}

MenuScreenWidgetModel defaultMenuScreenWidgetModelFactory(BuildContext context) {
  return MenuScreenWidgetModel(MenuScreenModel(context.user.petRepository));
}

class MenuScreenWidgetModel extends WidgetModel<MenuScreen, IMenuScreenModel>
    implements IMenuScreenWidgetModel {
  MenuScreenWidgetModel(MenuScreenModel super.model);

  final _cardSwiperController = CardSwiperController();

  @override
  CardSwiperController get cardSwiperController => _cardSwiperController;

  final _petsEntity = EntityStateNotifier<List<PetResponse>>();

  @override
  get petsListinable => _petsEntity;

  @override
  void initWidgetModel() {
    _initAsync();

    super.initWidgetModel();
  }

  Future<void> _initAsync() async {
    try {
      _petsEntity.loading();
      
      final res = await model.getPotentioalMatches();

      _petsEntity.content(res);


    } on Object {
      _petsEntity.error();
    }
  }

  @override
  Future<bool> onSwipe(int previousIndex, int? currentIndex, CardSwiperDirection direction) async {
    AppLogger.info(
      'The card $previousIndex was swiped to the ${direction.name}. Now the card $currentIndex is on top',
    );

    if(direction == CardSwiperDirection.right) {
      if(_petsEntity.value.data == null) return false;
      await model.likePet(_petsEntity.value.data![previousIndex].id, context.user.userController.currentPetNotifier.value!.id);
    }      
    return true;
  }

  @override
  Future<void> onCradTap(int index) async {

    if(_petsEntity.value.data == null) return;
    await context.router.push(PetRoute(pet: _petsEntity.value.data![index]));
  }

  @override
  bool onUndo(int? previousIndex, int currentIndex, CardSwiperDirection direction) {
    AppLogger.info(
      'The card $currentIndex was undod from the ${direction.name}',
    );
    return true;
  }

  @override
  MediaQueryData get mediaQuaery => wmMediaQuery;

  @override
  AppThemeData get theme => wmTheme;
}