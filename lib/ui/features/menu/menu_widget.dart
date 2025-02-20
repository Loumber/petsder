import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:petsder/ui/features/menu/menu_wm.dart';


@RoutePage()
class MenuScreen extends ElementaryWidget<IMenuScreenWidgetModel> {
  const MenuScreen({
    super.key
  }):super(defaultMenuScreenWidgetModelFactory);

  @override
  Widget build(IMenuScreenWidgetModel wm) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ХУй'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              'counter',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), 
    );
  }
}