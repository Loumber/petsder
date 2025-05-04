import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:petsder/ui/features/app_lodaing_error.dart/app_loading_error_widget.dart';
import 'package:petsder/ui/features/likes_or_messages/likes/likes_wm.dart';
import 'package:petsder/ui/features/likes_or_messages/likes/widgets/like_card.dart';
import 'package:petsder/ui/widgets/common/app_loading.dart';
class LikesWidgets extends ElementaryWidget<ILikesWidgetModel> {
  const LikesWidgets({
    super.key
  }):super(defaultLikesWidgetModelFactory);

  @override
  Widget build(ILikesWidgetModel wm) {
    return EntityStateNotifierBuilder(
      listenableEntityState: wm.likesListenable, 
      loadingBuilder:(context, data) => const AppLoading(),
      errorBuilder: (context, e, data) => const AppLoadingErrorWidget(),
      builder: (context, likes){
        if(likes == null) return const SizedBox();
        if(likes.isEmpty) return const Center(child: Text('У вас пока что нет лайков'));
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            itemCount: likes.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 2,
              childAspectRatio: 0.5,
            ),
            itemBuilder: (context, index){
              return GestureDetector(
                onTap:() => wm.onPetTap(index),
                child: LikeCard(
                  index: index,
                  name: likes[index].name,
                  age: likes[index].age,
                  discription: likes[index].description,
                  petPhotos: likes[index].photos,
                ),
              );
            }
          ),
        );
      }
    );
  }
}