import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petvillage/constant/colors_file.dart';
import 'package:petvillage/constant/common_widget.dart';
import '../../../../constant/const_string.dart';
import '../../../../constant/responsive.dart';
import '../../../product/view/product_view.dart';
import '../../controller/home_controller.dart';

class PetsCategoryWidget extends StatelessWidget {
  const PetsCategoryWidget({
    super.key,
    required this.controller,
  });

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Responsive.height * 15,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: byPets.length,
        itemBuilder: (context, index) {
          final data = byPets[index];
          return GestureDetector(
            onTap: () {
              Get.to(
                () => ProductView(tittle: data.title),
                arguments: data.api,
              );
            },
            child: Container(
              margin: EdgeInsets.only(
                right: Responsive.width * 3,
              ),
              height: Responsive.height * 25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.whiteColor,
              ),
              child: Column(
                children: [
                  Container(
                    height: 70,
                    width: 70,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.primary,
                      ),
                    ),
                    child: Image(
                      image: AssetImage(data.image),
                    ),
                  ),
                  SizedBox(height: Responsive.height * 1),
                  Common.text(
                    text: byPets[index].title,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blackColor,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ByPets {
  final String image;
  final String title;
  final String api;

  ByPets({
    required this.image,
    required this.title,
    required this.api,
  });
}

List<ByPets> byPets = [
  ByPets(
    image: ConstString.cat,
    title: "Cat",
    api: 'cat supplies',
  ),
  ByPets(
    image: ConstString.dog,
    title: "Dogs",
    api: 'dog supplies',
  ),
  ByPets(
    image: ConstString.bird,
    title: "Birds",
    api: 'bird supplies',
  ),
  ByPets(
    image: ConstString.smallPet,
    title: "Small Pets",
    api: 'small pets',
  ),
  ByPets(
    image: ConstString.fish,
    title: "Aquatic",
    api: 'aquatic',
  ),
];
