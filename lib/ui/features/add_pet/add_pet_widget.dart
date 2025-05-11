import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:petsder/data/models/enums/add_pet_state.dart';
import 'package:petsder/ui/features/add_pet/widgets/pet_photo.dart';
import 'package:petsder/ui/widgets/common/app_loading.dart';

import '../../../data/models/animal/animal_response.dart';
import '../../widgets/buttons/app_button.dart';
import '../app_lodaing_error.dart/app_loading_error_widget.dart';
import 'add_pet_wm.dart';

@RoutePage()
class AddPetScreen extends ElementaryWidget<IAddPetWidgetModel> {
  const AddPetScreen({super.key}) : super(defaultAddPetWidgetModelFactory);

  @override
  Widget build(IAddPetWidgetModel wm) {
    return SafeArea(
      child: Scaffold(
        body: SafeArea(
          child: ValueListenableBuilder<AddPetState>(
              valueListenable: wm.stateListenable,
              builder: (context, state, _) {
                if (state == AddPetState.main) {
                  return EntityStateNotifierBuilder(
                    listenableEntityState: wm.animalsListenable,
                    errorBuilder: (context, firstData, firstE) => const AppLoadingErrorWidget(),
                    loadingBuilder: (context, data) => const AppLoading(),
                    builder: (context, animals) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 32),
                            child: Text(
                              'Основная информация о питомце',
                              style: TextStyle(
                                color: wm.theme.main.inputFieldLabelColor,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: wm.nameController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Кличка питомца',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: wm.ageController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Возраст питомца',
                              ),
                              onTap: () => wm.onAgePetTap(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TypeAheadField<AnimalResponse>(
                              controller: wm.typeController,
                              itemBuilder: (context, animal) {
                                return ListTile(
                                  title: Text(
                                    animal.type,
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                );
                              },
                              onSelected: wm.onAnimalSelected,
                              suggestionsCallback: wm.filterAnimals,
                              builder: (context, controller, focusNode) {
                                return TextField(
                                  focusNode: focusNode,
                                  controller: controller,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Вид',
                                  ),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TypeAheadField<String>(
                              controller: wm.breedController,
                              itemBuilder: (context, breed) {
                                return ListTile(
                                  title: Text(
                                    breed,
                                  ),
                                );
                              },
                              onSelected: wm.onAnimalBreedSelected,
                              suggestionsCallback: wm.filterBreeds,
                              builder: (context, controller, focusNode) {
                                return TextField(
                                  focusNode: focusNode,
                                  controller: controller,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Порода',
                                  ),
                                );
                              },
                              errorBuilder: (context, e) => const ListTile(
                                title: Text(
                                  'Сначала укажите вид',
                                ),
                              ),
                              emptyBuilder: (context) => const SizedBox(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: EntityStateNotifierBuilder(
                              listenableEntityState: wm.genderListenable,
                              builder: (context, gender) {
                                return DropdownButton<String>(
                                  style: TextStyle(color: wm.theme.main.inputFieldLabelColor),
                                  dropdownColor: wm.theme.main.inputFieldBackgroundColor,
                                  borderRadius: BorderRadius.circular(16),
                                  value: gender,
                                  hint: const Text('Выберите пол'),
                                  items: const [
                                    DropdownMenuItem(
                                      alignment: Alignment.center,
                                      value: 'Самец',
                                      child: Text('Самец'),
                                    ),
                                    DropdownMenuItem(
                                      alignment: Alignment.center,
                                      value: 'Самка',
                                      child: Text('Самка'),
                                    ),
                                  ],
                                  onChanged: wm.onGenderSelected,
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AppButton(
                              text: 'Добавить питомца',
                              onPressed: wm.onAddPetPressed,
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
                if (state == AddPetState.photo) {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      EntityStateNotifierBuilder(
                          listenableEntityState: wm.photosListenable,
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
                                      onTap: () => wm.onPhotoTap(index),
                                      child: PetPhoto(
                                        image: photos[index],
                                      ),
                                    );
                                  }),
                            );
                          }),
                      AppButton(
                        text: 'Сохранить фотографии',
                        onPressed: wm.onSavePhotosPressed,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      RichText(
                          text: TextSpan(
                        text: 'Изменить информацию о питомце',
                        style: TextStyle(
                          color: wm.theme.main.inputFieldLabelColor,
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () => wm.onMainTap(),
                      )),
                      const SizedBox(
                        height: 85,
                      ),
                    ],
                  );
                }
                if (state == AddPetState.additional) {
                  return ValueListenableBuilder(
                      valueListenable: wm.loadingListenable,
                      builder: (context, loading, _) {
                        if (loading) return const AppLoading();
                        return Center(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 32),
                                child: Text(
                                  'Раскажите подробнее о своем питомце',
                                  style: TextStyle(
                                    color: wm.theme.main.inputFieldLabelColor,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  controller: wm.additionalInfoController,
                                  maxLines: 10,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: AppButton(
                                  text: 'Сохранить информацию о питомце',
                                  onPressed: wm.onSaveInfoTap,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RichText(
                                    text: TextSpan(
                                  text: 'Вернуться к выбору фотографий',
                                  style: TextStyle(
                                    color: wm.theme.main.inputFieldLabelColor,
                                    fontSize: 16,
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer()..onTap = () => wm.onPhotosTap(),
                                )),
                              ),
                            ],
                          ),
                        );
                      });
                }
                return const SizedBox();
              }),
        ),
      ),
    );
  }
}
