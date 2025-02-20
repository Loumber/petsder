import 'package:flutter/material.dart';

import '../../../ui/theme/theme.dart';
import '../di/scopes/global/global_scope.dart';

/// Common extensions on [BuildContext].
extension BuildContextExtension on BuildContext {  
  AppThemeData get theme => global.theme;

  MediaQueryData get mediaQuaery => MediaQuery.of(this);
}
