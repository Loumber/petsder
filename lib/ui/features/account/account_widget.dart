import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:petsder/ui/features/account/wigets/add_new_pet.dart';
import 'package:petsder/ui/features/account/wigets/pet_card.dart';
import 'package:petsder/ui/features/account/wigets/pet_item.dart';
import 'package:petsder/ui/features/account/wigets/settings.dart';

import 'account_wm.dart';

@RoutePage()
class AccountScreen extends ElementaryWidget<IAccountWidgetModel> {
  const AccountScreen({super.key}) : super(defaultAccountWidgetModelFactory);

  @override
  Widget build(IAccountWidgetModel wm) {
    return Scaffold(
      body: SafeArea(
          child: EntityStateNotifierBuilder(
        listenableEntityState: wm.petsListenable,
        builder: (context, pets) {
          if (pets == null) return const SizedBox();
          return ValueListenableBuilder(
              valueListenable: wm.currentPetListinable,
              builder: (context, currnetPet, _) {
                return CustomScrollView(
                  controller: wm.scrollController,
                  physics: const ClampingScrollPhysics(),
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SizedBox(
                          height: 60,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: pets.length + 1,
                              itemBuilder: (context, index) {
                                if (index == pets.length) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: AddNewPet(
                                      onTap: wm.onAddNewPetTap,
                                    ),
                                  );
                                }
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: PetItem(
                                    isSelected: wm.isCurrent(index),
                                    petName: pets[index].name,
                                    petPhoto: pets[index].photos.isNotEmpty ? pets[index].photos.first : '',
                                  ),
                                );
                              }),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 8,
                          left: 30,
                          right: 24,
                          bottom: 16,
                        ),
                        child: GestureDetector(
                          onTap: wm.onEditPetTap,
                          child: PetCard(
                            name: currnetPet!.name,
                            petPhotos: currnetPet.photos,
                            discription: currnetPet.description,
                            age: currnetPet.age,
                          ),
                        ),
                      )
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Settigs(
                          changeEmail: wm.onChangeEmailTap,
                          changePassword: wm.onChangePasswordTap,
                          signOut: wm.onSignOutTap,
                        ),
                      )
                    )
                  ],
                );
              }
            );
        },
      )),
    );
  }
}
