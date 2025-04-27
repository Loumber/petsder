import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:petsder/common/utils/extensions/buildcontext_extensions.dart';
import 'package:petsder/ui/features/edit_pet/edit_pet_wm.dart';
import 'package:petsder/ui/widgets/common/app_loading.dart';

@RoutePage()
class EditPetScreen extends ElementaryWidget<IEditPetWidgetModel> {
  const EditPetScreen({super.key}) : super(defaultEditPetWidgetModelFactory);

  @override
  Widget build(IEditPetWidgetModel wm) {
    return Scaffold(
      body: SafeArea(
          child: EntityStateNotifierBuilder(
              listenableEntityState: wm.currentPetListinable,
              loadingBuilder: (context, data) => const AppLoading(),
              builder: (context, pet) {
                if (pet == null) return const SizedBox();
                return CustomScrollView(
                  controller: wm.scrollController,
                  slivers: [
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 400,
                        child: Stack(
                          children: [
                            PageView.builder(
                              itemCount: pet.photos.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Image(
                                  image: NetworkImage(pet.photos[index]),
                                  fit: BoxFit.cover,
                                );
                              }
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: IconButton(
                                onPressed: wm.onBackTap,
                                icon: Icon(
                                  Icons.arrow_back_ios_rounded,
                                  color: context.theme.main.onPrimary,
                                  size: 40,
                                )
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                onPressed: wm.onPhotosEditTap,
                                icon: Icon(
                                  Icons.edit_outlined,
                                  color: context.theme.main.onPrimary,
                                  size: 40,
                                )
                              ),
                            )
                          ]
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Row(
                        children: [
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              pet.name, 
                              style: TextStyle(
                                color: context.theme.main.inputFieldLabelColor, 
                                fontSize: 48,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          IconButton(
                            onPressed: wm.onNameEditTap,
                            icon: Icon(
                              Icons.edit_outlined,
                              color: context.theme.main.inputFieldLabelColor,
                              size: 40,
                            )
                          ),
                        ],
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Row(
                        children: [
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              pet.age, 
                              style: TextStyle(
                                color: context.theme.main.inputFieldLabelColor, 
                                fontSize: 24,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          IconButton(
                            onPressed: wm.onPhotosEditTap,
                            icon: Icon(
                              Icons.edit_outlined,
                              color: context.theme.main.inputFieldLabelColor,
                              size: 24,
                            )
                          ),
                        ],
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Row(
                        children: [
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              pet.type,
                              style: TextStyle(
                                fontSize: 24,
                                color: context.theme.main.inputFieldLabelColor, 
                                fontWeight: FontWeight.w600
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          IconButton(
                            onPressed: wm.onPhotosEditTap,
                            icon: Icon(
                              Icons.edit_outlined,
                              color: context.theme.main.inputFieldLabelColor,
                              size: 24,
                            )
                          ),
                        ],
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Row(
                        children: [
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              pet.breed,
                              style: TextStyle(
                                fontSize: 24,
                                color: context.theme.main.inputFieldLabelColor, 
                                fontWeight: FontWeight.w600
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          IconButton(
                            onPressed: wm.onPhotosEditTap,
                            icon: Icon(
                              Icons.edit_outlined,
                              color: context.theme.main.inputFieldLabelColor,
                              size: 24,
                            )
                          ),
                        ],
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Row(
                        children: [
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              pet.gender,
                              style: TextStyle(
                                fontSize: 24,
                                color: context.theme.main.inputFieldLabelColor, 
                                fontWeight: FontWeight.w600
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          IconButton(
                            onPressed: wm.onPhotosEditTap,
                            icon: Icon(
                              Icons.edit_outlined,
                              color: context.theme.main.inputFieldLabelColor,
                              size: 24,
                            )
                          ),
                        ],
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Row(
                        children: [
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              pet.description,
                              style: TextStyle(
                                color: context.theme.main.inputFieldLabelColor, 
                                fontSize: 24,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          IconButton(
                            onPressed: wm.onPhotosEditTap,
                            icon: Icon(
                              Icons.edit_outlined,
                              color: context.theme.main.inputFieldLabelColor,
                              size: 24,
                            )
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
            )
          ),
    );
  }
}
