import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:petsder/data/models/pet/pet_response.dart';
import 'package:petsder/ui/features/edit_pet/edit_pet_widget.dart';
import 'package:petsder/ui/features/likes_or_messages/likes_or_messages_widget.dart';
import 'package:petsder/ui/features/menu/widgets/pet_screen.dart';
import 'package:petsder/ui/features/messaging/messaging_widget.dart';

import '../../../ui/features/account/account_widget.dart';
import '../../../ui/features/add_pet/add_pet_widget.dart';
import '../../../ui/features/auth/auth_widget.dart';
import '../../../ui/features/menu/menu_widget.dart';
import '../../../ui/features/navigation/navigation_screen.dart';
import '../../app/app.dart';
import '../di/wrappers/user_scope_wrapper.dart';
import 'auth_guards.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: 'Page|Screen,Route',
)
class AppRouter extends _$AppRouter {
  AppRouter() : super(navigatorKey: PetsderApp.navigatorGlobalKey);

  final authGuard = AuthGuard();

  @override
  RouteType get defaultRouteType => const RouteType.cupertino();

  @override
  List<AutoRoute> get routes => <AutoRoute>[
        AutoRoute(
          path: '/',
          initial: true,
          page: UserWrapperRoute.page,
          children: [
            AutoRoute(
                page: NavigationRoute.page,
                guards: [authGuard],
                path: '',
                children: [
                  CustomRoute(
                    page: MenuRoute.page,
                    initial: true,
                    path: '',
                    transitionsBuilder: TransitionsBuilders.noTransition,
                  ),
                  CustomRoute(
                    page: LikesOrMessagesRoute.page,
                    path: 'likes',
                    transitionsBuilder: TransitionsBuilders.noTransition,
                  ),
                  CustomRoute(
                    page: AccountRoute.page,
                    path: 'account',
                    transitionsBuilder: TransitionsBuilders.noTransition,
                  ),
                ]),
            AutoRoute(
              page: PetRoute.page,
              path: 'pet',
            ),
            AutoRoute(
              page: MessagingRoute.page,
              path: 'messaging',
            ),
            AutoRoute(
              page: EditPetRoute.page,
              path: 'edit-pet',
            ),
            AutoRoute(
              page: AuthRoute.page,
              path: 'login',
            ),
            AutoRoute(
              page: AddPetRoute.page,
              path: 'add-pet',
            )
          ],
        )
      ];
}
