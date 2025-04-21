import 'package:flutter/material.dart';
import 'package:petsder/common/utils/extensions/buildcontext_extensions.dart';

class PetItem extends StatelessWidget {
  const PetItem({
    super.key,
    required this.petName,
    required this.petPhoto,
    required this.isSelected,
  });

  final String petName;
  final String petPhoto;

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? context.theme.main.primary : context.theme.main.inputFieldBackgroundColor,
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundImage: NetworkImage(petPhoto),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              petName,
              style: TextStyle(
                fontSize: 16,
                color: isSelected ? context.theme.main.onPrimary : context.theme.main.inputFieldLabelColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
