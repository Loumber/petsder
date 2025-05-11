import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:petsder/common/utils/extensions/buildcontext_extensions.dart';
import 'package:petsder/ui/features/menu/menu_wm.dart';
import 'package:petsder/ui/features/menu/widgets/card_swiper/src/widget/card_swiper.dart';
import 'package:petsder/ui/features/menu/widgets/find_error_widget.dart';
import 'package:petsder/ui/features/menu/widgets/pet_card.dart';
import 'package:petsder/ui/widgets/common/app_loading.dart';

@RoutePage()
class MenuScreen extends ElementaryWidget<IMenuScreenWidgetModel> {
  const MenuScreen({super.key}) : super(defaultMenuScreenWidgetModelFactory);

  @override
  Widget build(IMenuScreenWidgetModel wm) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: EntityStateNotifierBuilder(
          listenableEntityState: wm.petsListinable,
          errorBuilder: (context, e, pets) => const FindErrorWidget(),
          loadingBuilder: (context, pets) => const AppLoading(),
          builder: (context, pets) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: pets != null && pets.isNotEmpty
                    ? CardSwiper(
                      isLoop: false,
                      controller: wm.cardSwiperController,
                      cardsCount: pets.length,
                      onSwipe: wm.onSwipe,
                      onUndo: wm.onUndo,
                      onEndWidget: const Text('Поблизости больше никого нет'),
                      cardBuilder: (
                        context,
                        index,
                        horizontalThresholdPercentage,
                        verticalThresholdPercentage,
                      ) {
                        final pet = pets[index];
                        return GestureDetector(
                          onTap:() => wm.onCradTap(index),
                          child: PetCard(
                            name: pet.name,
                            petPhotos: pet.photos,
                            discription: pet.description,
                            age: pet.age,
                          ),
                        );
                      }
                    )
                    : Text(
                      'Поблизости никого нет',
                      style: TextStyle(
                        color: context.theme.main.inputFieldLabelColor
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}