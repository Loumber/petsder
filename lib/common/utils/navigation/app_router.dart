import 'package:auto_route/auto_route.dart';



import '../../../ui/features/menu/menu_widget.dart';
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
          path: 'menu',
          page: MenuRoute.page,
        ),
      ],
    )
  ];

}
