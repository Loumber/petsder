import 'package:flutter/material.dart';
import 'package:petsder/common/utils/extensions/buildcontext_extensions.dart';

// ignore: must_be_immutable
class AddNewPet extends StatelessWidget {
  AddNewPet({
    super.key,
    required this.onTap,
  });

  Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24.0),
      child: Container(
        decoration: BoxDecoration(
          color: context.theme.main.inputFieldBackgroundColor,
          borderRadius: BorderRadius.circular(24.0),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: context.theme.main.inputFieldBackgroundColor,
              child: Icon(
                Icons.add_circle_outline_rounded,
                color: context.theme.main.inputFieldLabelColor,
              ),
            ),
            Text(
              'Добавить питомца',
              style: TextStyle(
                fontSize: 16,
                color: context.theme.main.inputFieldLabelColor,
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
