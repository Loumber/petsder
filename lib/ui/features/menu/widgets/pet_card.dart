import 'package:flutter/material.dart';
import 'package:petsder/common/utils/extensions/buildcontext_extensions.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PetCard extends StatelessWidget {
  PetCard({
    super.key,
    required this.petPhotos,
    required this.name,
    required this.discription,
    required this.age,
  });

  final String name;

  final String age;

  final String discription;

  final List<String> petPhotos;

  final _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: context.theme.main.inputFieldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
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
                      padding: const EdgeInsets.all(20.0),
                      child: SmoothPageIndicator(
                        controller: _controller,
                        count: petPhotos.length,
                        effect: ExpandingDotsEffect(
                          activeDotColor: context.theme.main.primary,
                          dotColor: context.theme.main.onPrimary,
                        ),
                      ),
                    )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$name ${calculateAge(age)}',
                  style: TextStyle(color: context.theme.main.inputFieldLabelColor, fontSize: 24, fontWeight: FontWeight.w600),
                ),
                Text(
                  discription,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: context.theme.main.inputFieldLabelColor, fontSize: 18, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          )
        ],
      ),
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
