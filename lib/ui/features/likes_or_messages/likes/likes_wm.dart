import 'package:auto_route/auto_route.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:elementary/elementary.dart';
import 'package:petsder/common/utils/di/scopes/user_info/user_info_scope.dart';
import 'package:petsder/common/utils/extensions/widget_model_extensions.dart';
import 'package:petsder/common/utils/navigation/app_router.dart';
import 'package:petsder/data/models/pet/pet_response.dart';
import 'package:petsder/ui/features/likes_or_messages/likes/likes_model.dart';
import 'package:petsder/ui/features/likes_or_messages/likes/likes_widgets.dart';
import 'package:petsder/ui/features/menu/widgets/pet_screen.dart';
import 'package:petsder/ui/theme/theme.dart';

abstract interface class ILikesWidgetModel implements IWidgetModel {
  Future<void> onPetTap(int index);

  EntityValueListenable<List<PetResponse>> get likesListenable;

  AppThemeData get theme;

  MediaQueryData get mediaQuaery;
}

LikesWidgetModel defaultLikesWidgetModelFactory(BuildContext context) {
  return LikesWidgetModel(LikesModel(
    context.user.petRepository,
  ));
}

class LikesWidgetModel extends WidgetModel<LikesWidgets, ILikesModel> implements ILikesWidgetModel {
  LikesWidgetModel(LikesModel super.model);

  final _likesEntity = EntityStateNotifier<List<PetResponse>>();

  @override
  EntityValueListenable<List<PetResponse>> get likesListenable => _likesEntity;

  @override
  void initWidgetModel() {
    _initAsync();

    super.initWidgetModel();
  }

  Future<void> _initAsync() async {
    try {
      _likesEntity.loading();
      _likesEntity.content(await model.getLikesPet());
    } on Object {
      _likesEntity.error();
    }
  }

  @override
  Future<void> onPetTap(int index) async {
    if (_likesEntity.value.data == null) return;
    await context.router.push(PetRoute(pet: _likesEntity.value.data![index]));
  }

  @override
  MediaQueryData get mediaQuaery => wmMediaQuery;

  @override
  AppThemeData get theme => wmTheme;
}
