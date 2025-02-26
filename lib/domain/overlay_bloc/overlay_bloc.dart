import 'package:flutter_bloc/flutter_bloc.dart';

import 'overlay_bloc_events.dart';
import 'overlay_bloc_state.dart';

class OverlayBloc extends Bloc<OverlayBlocEvents, OverlayBlocStates> {
  OverlayBloc() : super(OverlayBlocInitState()) {
    on<OverlayBlocShowEvent>(_showEvent);
    on<OverlayBlocShowSuccessEvent>(_showSuccessEvent);
  }

  /// Main event for [OverlayBloc]
  /// emit
  Future<void> _showEvent(OverlayBlocShowEvent event, Emitter<OverlayBlocStates> emit) async {
    emit(
      OverlayBlocShowNotificationState(
        notificationWidget: event.notificationWidget,
        duration: event.duration,
      ),
    );
  }

  Future<void> _showSuccessEvent(OverlayBlocShowSuccessEvent event, Emitter<OverlayBlocStates> emit) async {
    emit(
      OverlayBlocShowSuccessNotificationState(
        notificationSuccessText: event.notificationSuccessText,
        duration: event.duration,
        isShowSmile: event.isShowSmile,
      ),
    );
  }
}