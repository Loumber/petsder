import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:petsder/common/utils/extensions/buildcontext_extensions.dart';
import 'package:petsder/data/models/pet/pet_response.dart';

@RoutePage()
class PetScreen extends StatelessWidget {
  PetScreen({super.key, required this.pet});

  final PetResponse pet;

  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(
                height: 400,
                child: Stack(children: [
                  PageView.builder(
                      itemCount: pet.photos.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Image(
                          image: NetworkImage(pet.photos[index]),
                          fit: BoxFit.cover,
                        );
                      }),
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                        onPressed: context.router.maybePop,
                        icon: Icon(
                          Icons.arrow_back_ios_rounded,
                          color: context.theme.main.onPrimary,
                          size: 40,
                        )),
                  ),
                ]),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  pet.name,
                  style: TextStyle(
                      color: context.theme.main.inputFieldLabelColor, fontSize: 48, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  pet.age,
                  style: TextStyle(
                      color: context.theme.main.inputFieldLabelColor, fontSize: 24, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  pet.breed,
                  style: TextStyle(
                      fontSize: 24, color: context.theme.main.inputFieldLabelColor, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  pet.gender,
                  style: TextStyle(
                      fontSize: 24, color: context.theme.main.inputFieldLabelColor, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  pet.description,
                  style: TextStyle(
                      color: context.theme.main.inputFieldLabelColor, fontSize: 24, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        )),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(left: 35,bottom: 8),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 70,
              width: 70,
              child: FloatingActionButton(
                onPressed: () {},
                backgroundColor: context.theme.main.inputFieldBackgroundColor,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: context.theme.main.primary,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: SvgPicture.asset(
                  height: 30,
                  'assets/heart.svg',
                  colorFilter: ColorFilter.mode(
                    context.theme.main.primary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
