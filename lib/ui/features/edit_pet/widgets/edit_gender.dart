import 'dart:ui';

import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:petsder/common/utils/extensions/buildcontext_extensions.dart';
import 'package:petsder/ui/widgets/buttons/app_button.dart';

class EditGenderBottomSheet extends StatelessWidget {
  const EditGenderBottomSheet({
    required this.genderListenable,
    required this.onGenderSelected,
    required this.onSaveTap,
    super.key,
  });

  final ValueNotifier<EntityState<String>> genderListenable;

  final void Function(String? gender) onGenderSelected;

  final void Function()? onSaveTap;

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
                  const SizedBox(height: 150,),
                  SizedBox(
                    child: EntityStateNotifierBuilder(
                              listenableEntityState: genderListenable,
                              builder: (context, gender) {
                                return DropdownButton<String>(
                                  style: TextStyle(color: context.theme.main.inputFieldLabelColor),
                                  dropdownColor: context.theme.main.inputFieldBackgroundColor,
                                  borderRadius: BorderRadius.circular(16),
                                  value: gender,
                                  hint:  Center(
                                    child: Text(
                                      'Выберите пол',
                                      style: TextStyle(
                                        color: context.theme.main.inputFieldLabelColor
                                      ),
                                    ),
                                  ),
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
                                  onChanged: onGenderSelected,
                                );
                              },
                            ),
                  ),
                  const SizedBox(
                    height: 50,
                    width: double.infinity,
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
