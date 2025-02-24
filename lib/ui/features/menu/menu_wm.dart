import 'package:flutter/material.dart';
import 'package:elementary/elementary.dart';
import 'package:petsder/common/utils/extensions/widget_model_extensions.dart';
import 'package:petsder/ui/features/menu/menu_model.dart';
import 'package:petsder/ui/features/menu/menu_widget.dart';

import '../../theme/theme.dart';
abstract interface class IMenuScreenWidgetModel implements IWidgetModel {
  AppThemeData get theme;
  MediaQueryData get mediaQuaery;
}

MenuScreenWidgetModel defaultMenuScreenWidgetModelFactory(BuildContext context) {
  return MenuScreenWidgetModel(MenuScreenModel());
}

class MenuScreenWidgetModel extends WidgetModel<MenuScreen, IMenuScreenModel>
    implements IMenuScreenWidgetModel {
  MenuScreenWidgetModel(MenuScreenModel super.model);


  @override
  MediaQueryData get mediaQuaery => wmMediaQuery;

  @override
  AppThemeData get theme => wmTheme;
}