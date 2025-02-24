import 'package:flutter/material.dart';
import 'package:elementary/elementary.dart';
import 'package:petsder/common/utils/extensions/widget_model_extensions.dart';


import '../../theme/theme.dart';
import 'app_loading_error_model.dart';
import 'app_loading_error_widget.dart';
abstract interface class IAppLoadingErrorWidgetModel implements IWidgetModel {

  AppThemeData get theme;
  MediaQueryData get mediaQuaery;
}

AppLoadingErrorWidgetModel defaultAppLoadingErrorWidgetModelFactory(BuildContext context) {
  return AppLoadingErrorWidgetModel(AppLoadingErrorModel());
}

class AppLoadingErrorWidgetModel extends WidgetModel<AppLoadingErrorWidget, IAppLoadingErrorModel>
    implements IAppLoadingErrorWidgetModel {
  AppLoadingErrorWidgetModel(super.model);


  
  @override
  MediaQueryData get mediaQuaery => wmMediaQuery;

  @override
  AppThemeData get theme => wmTheme;
}