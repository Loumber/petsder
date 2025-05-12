import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:petsder/common/utils/extensions/buildcontext_extensions.dart';
import 'package:petsder/data/models/animal/animal_response.dart';
import 'package:petsder/ui/widgets/buttons/app_button.dart';

class EditTypeBottomSheet extends StatelessWidget {
  const EditTypeBottomSheet({
    required this.controller,
    required this.onSaveTap,
    required this.animalList,
    required this.onSelected,
    super.key
  });

  final TextEditingController controller;

  final void Function()? onSaveTap;

  final void Function(AnimalResponse selectedAnimal)? onSelected;

  final List<AnimalResponse> Function(String) animalList;

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
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 75,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TypeAheadField<AnimalResponse>(
                        controller: controller,
                        itemBuilder: (context, animal) {
                          return ListTile(
                            tileColor: context.theme.main.inputFieldBackgroundColor,
                            title: Text(
                              animal.type,
                              style: TextStyle(color: context.theme.main.inputFieldLabelColor),
                            ),
                          );
                        },
                        onSelected: onSelected,
                        suggestionsCallback: animalList,
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
                  ),
                  AppButton(
                    text: 'Сохранить',
                    onPressed: onSaveTap,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
