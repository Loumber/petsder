import 'package:flutter/widgets.dart';

abstract class OverlayBlocStates {}

/// Initial state
class OverlayBlocInitState extends OverlayBlocStates {}

/// State for showing [notification]
class OverlayBlocShowNotificationState extends OverlayBlocStates {
  OverlayBlocShowNotificationState({
    required this.notificationWidget,
    required this.duration,
  });

  Widget notificationWidget;
  Duration duration;
}

class OverlayBlocShowSuccessNotificationState extends OverlayBlocStates {
  OverlayBlocShowSuccessNotificationState({
    required this.notificationSuccessText,
    required this.duration,
    required this.isShowSmile,
  });

  bool isShowSmile;
  String notificationSuccessText;
  Duration duration;
}
