import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:petsder/common/utils/navigation/app_router.dart';

import 'navigation_wm.dart';

@RoutePage()
class NavigationScreen extends ElementaryWidget<INavigationWidgetModel> {
  const NavigationScreen({
    super.key
  }):super(defaultNavigationWidgetModelFactory);

  @override
  Widget build(INavigationWidgetModel wm) {
  return AutoTabsScaffold(
    routes: const [
      MenuRoute(),
    ],
    bottomNavigationBuilder: (context, router) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Placeholder(),
          BottomNavigationBar(
            currentIndex: router.activeIndex,
            onTap: router.setActiveIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
            ],
          ),
        ],
      );
    },
  );
}

}