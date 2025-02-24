import 'package:flutter/material.dart';
import 'package:elementary/elementary.dart';
import 'package:petsder/common/utils/extensions/widget_model_extensions.dart';
import 'package:petsder/ui/features/navigation/navigation_screen.dart';

import '../../theme/theme.dart';
import 'navigation_screen_model.dart';
abstract interface class INavigationWidgetModel implements IWidgetModel {
  
  AppThemeData get theme;
  MediaQueryData get mediaQuaery;
}

NavigationWidgetModel defaultNavigationWidgetModelFactory(BuildContext context) {
  return NavigationWidgetModel(NavigationModel());
}

class NavigationWidgetModel extends WidgetModel<NavigationScreen, INavigationModel>
    implements INavigationWidgetModel {
  NavigationWidgetModel(NavigationModel super.model);
  

  @override
  MediaQueryData get mediaQuaery => wmMediaQuery;

  @override
  AppThemeData get theme => wmTheme;
}