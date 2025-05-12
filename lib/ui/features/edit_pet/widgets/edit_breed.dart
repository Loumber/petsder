import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:petsder/common/utils/extensions/buildcontext_extensions.dart';
import 'package:petsder/ui/widgets/buttons/app_button.dart';

class EditBreedBottomSheet extends StatelessWidget {
  const EditBreedBottomSheet({
    required this.breedController,
    required this.onSaveTap,
    required this.breedList,
    required this.onSelected,
    super.key
  });

  final TextEditingController breedController;

  final void Function()? onSaveTap;

  final void Function(String selectedAnimal)? onSelected;

  final List<String> Function(String) breedList;

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
                      child: TypeAheadField<String>(
                        controller: breedController,
                        itemBuilder: (context, breed) {
                          return ListTile(
                            title: Text(
                              breed,
                            ),
                          );
                        },
                        onSelected: onSelected,
                        suggestionsCallback: breedList,
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
