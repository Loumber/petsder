import 'package:flutter/material.dart';
import 'package:elementary/elementary.dart';
import 'package:petsder/ui/features/menu/menu_model.dart';
import 'package:petsder/ui/features/menu/menu_widget.dart';
abstract interface class IMenuScreenWidgetModel implements IWidgetModel {
  /*AppLocalizations get locale;
  AppThemeData get theme;
  MediaQueryData get mediaQuaery;*/
}

MenuScreenWidgetModel defaultMenuScreenWidgetModelFactory(BuildContext context) {
  return MenuScreenWidgetModel(MenuScreenModel());
}

class MenuScreenWidgetModel extends WidgetModel<MenuScreen, IMenuScreenModel>
    implements IMenuScreenWidgetModel {
  MenuScreenWidgetModel(MenuScreenModel super.model);

  /*@override
  AppLocalizations get locale => wmLocale;

  @override
  MediaQueryData get mediaQuaery => wmMediaQuery;

  @override
  AppThemeData get theme => wmTheme;*/
}