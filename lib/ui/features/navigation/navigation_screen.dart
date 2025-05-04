import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:petsder/common/utils/extensions/buildcontext_extensions.dart';
import 'package:petsder/common/utils/navigation/app_router.dart';

import 'navigation_wm.dart';

@RoutePage()
class NavigationScreen extends ElementaryWidget<INavigationWidgetModel> {
  const NavigationScreen({super.key}) : super(defaultNavigationWidgetModelFactory);

  @override
  Widget build(INavigationWidgetModel wm) {
    return AutoTabsScaffold(
      routes: const [MenuRoute(), LikesOrMessagesRoute(), AccountRoute()],
      bottomNavigationBuilder: (context, router) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BottomNavigationBar(
              selectedItemColor: context.theme.main.primary,
              currentIndex: router.activeIndex,
              onTap: router.setActiveIndex,
              items: [
                const BottomNavigationBarItem(icon: Icon(Icons.search_rounded), label: 'Поиск'),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/heart-sms.svg',
                    width: 20,
                    height: 20,
                    colorFilter: ColorFilter.mode(
                      router.activeIndex == 1 ? context.theme.main.primary : context.theme.main.inputFieldLabelColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  label: 'Общение',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Аккаунт',
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
