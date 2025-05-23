// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AccountRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AccountScreen(),
      );
    },
    AddPetRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AddPetScreen(),
      );
    },
    AuthRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AuthScreen(),
      );
    },
    EditPetRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const EditPetScreen(),
      );
    },
    LikesOrMessagesRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LikesOrMessagesScreen(),
      );
    },
    MenuRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MenuScreen(),
      );
    },
    MessagingRoute.name: (routeData) {
      final args = routeData.argsAs<MessagingRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: MessagingScreen(
          id: args.id,
          name: args.name,
          photoUrl: args.photoUrl,
          key: args.key,
        ),
      );
    },
    NavigationRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const NavigationScreen(),
      );
    },
    PetRoute.name: (routeData) {
      final args = routeData.argsAs<PetRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: PetScreen(
          key: args.key,
          pet: args.pet,
        ),
      );
    },
    UserWrapperRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const UserWrapperScreen(),
      );
    },
  };
}

/// generated route for
/// [AccountScreen]
class AccountRoute extends PageRouteInfo<void> {
  const AccountRoute({List<PageRouteInfo>? children})
      : super(
          AccountRoute.name,
          initialChildren: children,
        );

  static const String name = 'AccountRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [AddPetScreen]
class AddPetRoute extends PageRouteInfo<void> {
  const AddPetRoute({List<PageRouteInfo>? children})
      : super(
          AddPetRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddPetRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [AuthScreen]
class AuthRoute extends PageRouteInfo<void> {
  const AuthRoute({List<PageRouteInfo>? children})
      : super(
          AuthRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [EditPetScreen]
class EditPetRoute extends PageRouteInfo<void> {
  const EditPetRoute({List<PageRouteInfo>? children})
      : super(
          EditPetRoute.name,
          initialChildren: children,
        );

  static const String name = 'EditPetRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LikesOrMessagesScreen]
class LikesOrMessagesRoute extends PageRouteInfo<void> {
  const LikesOrMessagesRoute({List<PageRouteInfo>? children})
      : super(
          LikesOrMessagesRoute.name,
          initialChildren: children,
        );

  static const String name = 'LikesOrMessagesRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MenuScreen]
class MenuRoute extends PageRouteInfo<void> {
  const MenuRoute({List<PageRouteInfo>? children})
      : super(
          MenuRoute.name,
          initialChildren: children,
        );

  static const String name = 'MenuRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MessagingScreen]
class MessagingRoute extends PageRouteInfo<MessagingRouteArgs> {
  MessagingRoute({
    required String id,
    required String name,
    required String photoUrl,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          MessagingRoute.name,
          args: MessagingRouteArgs(
            id: id,
            name: name,
            photoUrl: photoUrl,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'MessagingRoute';

  static const PageInfo<MessagingRouteArgs> page =
      PageInfo<MessagingRouteArgs>(name);
}

class MessagingRouteArgs {
  const MessagingRouteArgs({
    required this.id,
    required this.name,
    required this.photoUrl,
    this.key,
  });

  final String id;

  final String name;

  final String photoUrl;

  final Key? key;

  @override
  String toString() {
    return 'MessagingRouteArgs{id: $id, name: $name, photoUrl: $photoUrl, key: $key}';
  }
}

/// generated route for
/// [NavigationScreen]
class NavigationRoute extends PageRouteInfo<void> {
  const NavigationRoute({List<PageRouteInfo>? children})
      : super(
          NavigationRoute.name,
          initialChildren: children,
        );

  static const String name = 'NavigationRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [PetScreen]
class PetRoute extends PageRouteInfo<PetRouteArgs> {
  PetRoute({
    Key? key,
    required PetResponse pet,
    List<PageRouteInfo>? children,
  }) : super(
          PetRoute.name,
          args: PetRouteArgs(
            key: key,
            pet: pet,
          ),
          initialChildren: children,
        );

  static const String name = 'PetRoute';

  static const PageInfo<PetRouteArgs> page = PageInfo<PetRouteArgs>(name);
}

class PetRouteArgs {
  const PetRouteArgs({
    this.key,
    required this.pet,
  });

  final Key? key;

  final PetResponse pet;

  @override
  String toString() {
    return 'PetRouteArgs{key: $key, pet: $pet}';
  }
}

/// generated route for
/// [UserWrapperScreen]
class UserWrapperRoute extends PageRouteInfo<void> {
  const UserWrapperRoute({List<PageRouteInfo>? children})
      : super(
          UserWrapperRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserWrapperRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
