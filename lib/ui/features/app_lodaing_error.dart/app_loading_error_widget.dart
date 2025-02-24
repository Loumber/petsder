import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

import 'app_loading_error_wm.dart';
 

class AppLoadingErrorWidget extends ElementaryWidget<IAppLoadingErrorWidgetModel> {
  const AppLoadingErrorWidget({
    super.key
  }):super(defaultAppLoadingErrorWidgetModelFactory);

  @override
  Widget build(IAppLoadingErrorWidgetModel wm) {
    return const Scaffold(
      body: Center(
        child: Text('Упс...'),
      ),
    );
  }
}