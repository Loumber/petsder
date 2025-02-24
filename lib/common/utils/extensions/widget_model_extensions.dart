import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:petsder/common/utils/di/scopes/global/global_scope.dart';

import '../../../ui/theme/theme.dart';

extension ElementaryExtension on WidgetModel {
  /// Returns current [ThemeData].
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  AppThemeData get wmTheme => context.global.theme;

  /// Return MediaQuery
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  MediaQueryData get wmMediaQuery => MediaQuery.of(context);
}