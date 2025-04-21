import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:petsder/ui/features/likes/likes_wm.dart';


@RoutePage()
class LikesScreen extends ElementaryWidget<ILikesWidgetModel> {
  const LikesScreen({
    super.key
  }):super(defaultLikesWidgetModelFactory);

  @override
  Widget build(ILikesWidgetModel wm) {
    return Container();
  }
}