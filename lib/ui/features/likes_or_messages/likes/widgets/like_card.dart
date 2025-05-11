import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:petsder/common/utils/extensions/buildcontext_extensions.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// ignore: must_be_immutable
class LikeCard extends StatelessWidget {
  LikeCard(
      {super.key,
      required this.name,
      required this.age,
      required this.discription,
      required this.petPhotos,
      required this.onLikeTap,
  });


  final String name;

  final String age;

  final String discription;

  final List<String> petPhotos;

  final _controller = PageController();

  final Function() onLikeTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          width: 300,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            child: Stack(children: [
              PageView.builder(
                  controller: _controller,
                  itemCount: petPhotos.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Image(
                      image: NetworkImage(petPhotos[index]),
                      fit: BoxFit.cover,
                    );
                  }),
              Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: SmoothPageIndicator(
                      controller: _controller,
                      count: petPhotos.length,
                      effect: ExpandingDotsEffect(
                        activeDotColor: context.theme.main.primary,
                        dotColor: context.theme.main.onPrimary,
                      ),
                    ),
                  )),
              Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                      padding: const EdgeInsets.only(bottom: 8, left: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '$name ${calculateAge(age)}',
                            style: TextStyle(
                                color: context.theme.main.onPrimary, fontSize: 24, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ))),
            ]),
          ),
        ),
        GestureDetector(
          onTap: onLikeTap,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
            child: SizedBox(
              height: 50,
              width: 300,
              child: ColoredBox(
                color: context.theme.main.inputFieldBackgroundColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    'assets/heart.svg',
                    colorFilter: ColorFilter.mode(
                      context.theme.main.inputFieldLabelColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  String calculateAge(String birthDateString) {
    try {
      final parts = birthDateString.split('.');
      if (parts.length != 3) return 'неизвестен';

      final day = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final year = int.parse(parts[2]);

      final birthDate = DateTime(year, month, day);
      final now = DateTime.now();

      int years = now.year - birthDate.year;
      int months = now.month - birthDate.month;
      int days = now.day - birthDate.day;

      if (days < 0) {
        months -= 1;
      }
      if (months < 0) {
        years -= 1;
        months += 12;
      }

      if (years < 0) return 'неизвестен';

      if (years == 0 && months == 0) return 'менее месяца';
      if (years == 0) return '$months мес.';
      if (months == 0) return '$years г.';

      return '$years г. $months мес.';
    } catch (e) {
      return 'неизвестен';
    }
  }
}
