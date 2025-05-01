import 'dart:async';

import 'package:flutter/material.dart';
import 'package:petsder/common/utils/di/app_async_dependency.dart';
import 'package:petsder/common/utils/di/scopes/global/global_scope.dart';
import 'package:petsder/domain/notification/notitfication_repository.dart';
import 'package:petsder/domain/pet/pet_repository.dart';
import 'package:petsder/domain/user/user_controller.dart';
import 'package:provider/provider.dart';

import '../../../../../domain/auth/auth_repository.dart';
import '../../../../../domain/overlay_bloc/overlay_bloc_state.dart';
import '../../../../../ui/widgets/common/overlay_notification_widget.dart';
import '../../../../../ui/widgets/common/success_overlay_notification_widget.dart';

class UserInfoDependency extends AppAsyncDependency {

  late final StreamSubscription<OverlayBlocStates>? _overlayBlocSteamSubscription;

  late final AuthRepository authRepository;

  late final PetRepository petRepository;

  late final NotificationRepository notificationRepository;

  Timer? _statusFlowForRateOrderTimer;

  late final UserController userController;


  @override
  Future<void> initAsync(BuildContext context) async {


    notificationRepository = NotificationRepository();

    try{
      notificationRepository.initNotifications();
    } on Object {
      rethrow;
    }

    await _initOverlayBlocSubscription(context);
    authRepository = AuthRepository();
    petRepository = PetRepository();
    await petRepository.getCurrentPet();
    // ignore: use_build_context_synchronously
    await petRepository.setGeoHashForCurrentPet(context.global.geolocationRepository.getGeoHash(await context.global.geolocationRepository.getCurrentPosition()));
    await petRepository.getCurrentPet();
    userController = UserController(currentPetNotifier:  petRepository.currentPetNotifier);
  }
  
  @override
  Future<void> onError(BuildContext context) async {
    await _overlayBlocSteamSubscription?.cancel();
    _statusFlowForRateOrderTimer?.cancel();
  }

  Future<void> updateCurrentPet() async => userController.currentPetNotifier.value = petRepository.currentPetNotifier.value;

  Future<void> _initOverlayBlocSubscription(BuildContext context) async {
    final overlay = Overlay.of(context);
    _overlayBlocSteamSubscription = context.global.overlayBloc.stream.listen((state) {
      onOverlayBlocEvent(state, overlay);
    });
  }

  bool _showOverlay = false;

  Future<void> onOverlayBlocEvent(OverlayBlocStates state, OverlayState overlay) async {
    if (_showOverlay) return;
    _showOverlay = true;

    if (state is OverlayBlocShowNotificationState) {
      final entry = OverlayEntry(
        builder: (context) {
          return OverlayNotification(
            notificationWidget: state.notificationWidget,
            animationCompleteCallback: () {},
            duration: state.duration,
          );
        },
      );
      overlay.insert(entry);

      /// Once the overlay has been hidden after a certain duration, it can be shown again
      await Future<void>.delayed(
        state.duration,
        () => _showOverlay = false,
      ).onError((e, st) => _showOverlay = false);

      entry.remove();
    }

    if (state is OverlayBlocShowSuccessNotificationState) {
      final entry = OverlayEntry(
        builder: (context) {
          return SuccessOverlayNotificationWidget(
            notificationSuccessText: state.notificationSuccessText,
            animationCompleteCallback: () {},
            duration: state.duration,
            isShowSmile: state.isShowSmile,
          );
        },
      );
      overlay.insert(entry);

      /// Once the overlay has been hidden after a certain duration, it can be shown again
      await Future<void>.delayed(
        state.duration,
        () => _showOverlay = false,
      ).onError((e, st) => _showOverlay = false);

      entry.remove();
    }
  }

  
}

extension DepContextExtension on BuildContext {
  UserInfoDependency get user => read<UserInfoDependency>();
}