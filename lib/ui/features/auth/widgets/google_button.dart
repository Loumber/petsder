import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petsder/common/utils/extensions/buildcontext_extensions.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({
    super.key, 
    required this.onTap,
  });

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 80,
        height: 80,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              width: 4,
              color: context.theme.main.primary,
            ),
            color: context.theme.main.googleButton,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SvgPicture.asset(
              'assets/google-logo.svg',
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
      ),
    );
  }
}