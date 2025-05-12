import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:petsder/common/utils/extensions/buildcontext_extensions.dart';
import 'package:petsder/ui/widgets/buttons/app_button.dart';

class EditNameBottomSheet extends StatelessWidget {
  const EditNameBottomSheet({
    required this.controller,
    required this.onSaveTap,
    super.key,
  });

  final TextEditingController controller;

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
                  SizedBox(
                    height: 75,
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        fillColor: context.theme.main.inputFieldBackgroundColor,
                        border: const OutlineInputBorder(),
                        labelText: 'Введите новое имя питомца',
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
