import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

import 'account_wm.dart';

@RoutePage()
class AccountScreen extends ElementaryWidget<IAccountWidgetModel> {
  const AccountScreen({
    super.key
  }):super(defaultAccountWidgetModelFactory);

  @override
  Widget build(IAccountWidgetModel wm) {
    return Container();
  }
}