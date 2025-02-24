import 'package:auto_route/auto_route.dart';



import '../../../ui/features/menu/menu_widget.dart';
import '../../../ui/features/navigation/navigation_screen.dart';
import '../../app/app.dart';
import '../di/wrappers/user_scope_wrapper.dart';

part 'app_router.gr.dart';


@AutoRouterConfig(
  replaceInRouteName: 'Page|Screen,Route',
)
class AppRouter extends _$AppRouter {
  AppRouter() : super(navigatorKey: PetsderApp.navigatorGlobalKey);

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
          path: '',
          children: [
            CustomRoute(
              page: MenuRoute.page,
              initial: true,
              path: '',
              transitionsBuilder: TransitionsBuilders.noTransition,
            ),
          ]
        ),
        
      ],
    )
  ];

}
