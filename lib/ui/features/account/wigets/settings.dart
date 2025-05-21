import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petsder/common/utils/extensions/buildcontext_extensions.dart';

class Settigs extends StatelessWidget {
  const Settigs(
      {super.key,
      required this.signOut,
      required this.changePassword,
      required this.changeEmail,
      required this.sliderValueNotifier});

  static const List<int> _radiusOptions = [1, 5, 20, 80, 250];

  final void Function()? changeEmail;

  final void Function()? changePassword;

  final ValueNotifier<double> sliderValueNotifier;

  static const Map<int, String> _geohashPrecisionToRadiusDescription = {
    1: 'Очень широкий охват (~2500 км)',
    2: 'Континент / страна (~630 км)',
    3: 'Регион / область (~78 км)',
    4: 'Город (~20 км)',
    5: 'Район (~2.4 км)',
    6: 'Несколько улиц (~610 м)',
    7: 'Дом или квартал (~76 м)',
    8: 'Точное местоположение (~19 м)',
  };


  final void Function()? signOut;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Область поиска',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: context.theme.main.inputFieldLabelColor,
          ),
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 8,
            valueIndicatorTextStyle: const TextStyle(
              fontSize: 16,
            ),
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
            tickMarkShape: const RoundSliderTickMarkShape(tickMarkRadius: 3),
            activeTickMarkColor: context.theme.main.onPrimary,
            inactiveTickMarkColor: context.theme.main.onPrimary,
          ), 
          child: 
          Slider(
            label: _geohashPrecisionToRadiusDescription[sliderValueNotifier.value.round()],
            divisions: _radiusOptions.length,
            min: 1,
            max: 8,
            activeColor: context.theme.main.primary,
            inactiveColor: context.theme.main.inputFieldBorderColor,
            value: sliderValueNotifier.value,
            onChanged: (double value) {
              sliderValueNotifier.value = value;
            }
          ),
        ),
        
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          width: 375,
          child: CupertinoButton(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: context.theme.main.inputFieldBackgroundColor,
            onPressed: changeEmail,
            child: Text(
              'Изменить почту',
              style: TextStyle(color: context.theme.main.inputFieldLabelColor),
            ),
          ),
        ),
        const SizedBox(
          height: 2,
        ),
        SizedBox(
          width: 375,
          child: CupertinoButton(
            borderRadius: const BorderRadius.all(Radius.zero),
            color: context.theme.main.inputFieldBackgroundColor,
            onPressed: changePassword,
            child: Text(
              'Изменить пароль',
              style: TextStyle(color: context.theme.main.inputFieldLabelColor),
            ),
          ),
        ),
        const SizedBox(
          height: 2,
        ),
        SizedBox(
          width: 375,
          child: CupertinoButton(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              color: context.theme.main.primary,
              onPressed: signOut,
              child: Text(
                'Выйти',
                style: TextStyle(color: context.theme.main.onPrimary),
              )),
        )
      ],
    );
  }
}
