import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:petsder/common/utils/di/app_async_dependency.dart';
import 'package:petsder/common/utils/navigation/app_router.dart';
import 'package:petsder/domain/animal/animal_repository.dart';
import 'package:petsder/domain/pet/pet_repository.dart';
import 'package:provider/provider.dart';

import '../../../../../domain/overlay_bloc/overlay_bloc.dart';
import '../../../../../ui/theme/theme.dart';

class GlobalDependency extends AppAsyncDependency {
  
  late AppThemeData theme = SchedulerBinding.instance.platformDispatcher.platformBrightness == Brightness.light
    ? AppThemeData.light()
    : AppThemeData.dark();

  late final AppRouter router;

  late final OverlayBloc overlayBloc;

  late final AnimalRepository animalRepository;

  late final PetRepository petRepository;

  @override
  Future<void> initAsync(BuildContext context) async {
    router = AppRouter();

    overlayBloc = OverlayBloc();

    animalRepository = AnimalRepository();

    petRepository = PetRepository();
  }

  @override
  Future<void> onError(BuildContext context) {
    
    throw UnimplementedError();
  }
  
}

extension DepContextExtention on BuildContext{
  GlobalDependency get global => read<GlobalDependency>();
}