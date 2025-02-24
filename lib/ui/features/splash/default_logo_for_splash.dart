import 'package:flutter/material.dart';
import 'package:petsder/common/utils/extensions/buildcontext_extensions.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DefaultLogoForSplash extends StatelessWidget {
  const DefaultLogoForSplash({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.theme.main.primary,
      child: Center(
        child: SizedBox(
          height: 200,
          child: SvgPicture.asset(
            'assets/pets.svg',
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
    );
  }
}