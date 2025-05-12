import 'dart:ui';

import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:petsder/common/utils/extensions/buildcontext_extensions.dart';
import 'package:petsder/data/models/editable_photo/editable_photo.dart';
import 'package:petsder/ui/features/edit_pet/widgets/pet_photo.dart';
import 'package:petsder/ui/widgets/buttons/app_button.dart';

class EditPhotos extends StatelessWidget {
  const EditPhotos(
      {super.key, required this.photosListenable, required this.onPhotoTap, required this.onSavePhotosPressed});

  final ValueNotifier<EntityState<List<EditablePhoto?>>> photosListenable;
  final void Function(int) onPhotoTap;
  final void Function() onSavePhotosPressed;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 3,
            sigmaY: 3,
          ),
          child: Material(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
            color: context.theme.main.inputFieldBackgroundColor,
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                EntityStateNotifierBuilder(
                    listenableEntityState: photosListenable,
                    builder: (context, photos) {
                      if (photos == null) return const SizedBox();
                      return Expanded(
                        child: GridView.builder(
                            padding: const EdgeInsets.all(16),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 15,
                              mainAxisSpacing: 15,
                              childAspectRatio: 0.6,
                            ),
                            itemCount: photos.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () => onPhotoTap(index),
                                child: PetPhoto(
                                  image: photos[index],
                                ),
                              );
                            }),
                      );
                    }),
                Padding(
                  padding: const EdgeInsets.only(bottom: 64.0),
                  child: AppButton(
                    text: 'Сохранить фотографии',
                    onPressed: onSavePhotosPressed,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
