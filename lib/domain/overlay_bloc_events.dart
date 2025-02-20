import 'package:flutter/widgets.dart';

abstract class OverlayBlocEvents {}

/// Main event to show overlay
class OverlayBlocShowEvent extends OverlayBlocEvents {
  OverlayBlocShowEvent({
    required this.notificationWidget,
    required this.duration,
  }) : assert(duration.inMilliseconds > 2, 'Duration must be more than 2 milliseconds');

  /// Widget that will be displayed inside overlay notification
  Widget notificationWidget;

  /// Duration of notificationWidget display
  Duration duration;
}

class OverlayBlocShowSuccessEvent extends OverlayBlocEvents {
  OverlayBlocShowSuccessEvent({
    required this.notificationSuccessText,
    required this.duration,
    this.isShowSmile = false,
  }) : assert(duration.inMilliseconds > 2, 'Duration must be more than 2 milliseconds');

  bool isShowSmile;
  
  String notificationSuccessText;
  Duration duration;
}