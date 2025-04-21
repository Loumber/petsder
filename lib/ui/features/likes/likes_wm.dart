import 'package:flutter/material.dart';
import 'package:elementary/elementary.dart';
import 'package:petsder/common/utils/extensions/widget_model_extensions.dart';
import 'package:petsder/ui/features/likes/likes_model.dart';
import 'package:petsder/ui/features/likes/likes_widget.dart';
import 'package:petsder/ui/theme/theme.dart';

abstract interface class ILikesWidgetModel implements IWidgetModel {
  AppThemeData get theme;
  MediaQueryData get mediaQuaery;
}

LikesWidgetModel defaultLikesWidgetModelFactory(BuildContext context) {
  return LikesWidgetModel(LikesModel());
}

class LikesWidgetModel extends WidgetModel<LikesScreen, ILikesModel> implements ILikesWidgetModel {
  LikesWidgetModel(LikesModel super.model);

  @override
  MediaQueryData get mediaQuaery => wmMediaQuery;

  @override
  AppThemeData get theme => wmTheme;
}
