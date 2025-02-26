import 'package:flutter/material.dart';
import 'package:elementary/elementary.dart';
import 'package:petsder/common/utils/extensions/widget_model_extensions.dart';
import 'package:petsder/ui/features/account/account_widget.dart';

import '../../theme/theme.dart';
import 'account_model.dart';

abstract interface class IAccountWidgetModel implements IWidgetModel {

  AppThemeData get theme;
  
  MediaQueryData get mediaQuaery;
}

AccountWidgetModel defaultAccountWidgetModelFactory(BuildContext context) {
  return AccountWidgetModel(AccountModel());
}

class AccountWidgetModel extends WidgetModel<AccountScreen, IAccountModel>
    implements IAccountWidgetModel {
  AccountWidgetModel(AccountModel super.model);



  @override
  MediaQueryData get mediaQuaery => wmMediaQuery;

  @override
  AppThemeData get theme => wmTheme;
}