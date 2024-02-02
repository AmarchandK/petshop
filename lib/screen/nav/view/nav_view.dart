import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:petvillage/constant/colors_file.dart';
import 'package:petvillage/screen/nav/controller/nav_controller.dart';

import '../../../constant/responsive.dart';

class NavView extends StatefulWidget {
  const NavView({super.key});

  @override
  State<NavView> createState() => _NavViewState();
}

class _NavViewState extends State<NavView> {
  final controller = Get.put(NavController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavController>(
      builder: (obj) {
        return Stack(
          children: [
            Scaffold(
              body: obj.pages[obj.currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                iconSize: 25,
                backgroundColor: AppColors.whiteColor,
                elevation: 0,
                selectedItemColor: AppColors.primary,
                unselectedItemColor: Colors.black,
                type: BottomNavigationBarType.fixed,
                onTap: (value) => obj.changePage(value),
                currentIndex: obj.currentIndex,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(
                      obj.currentIndex == 0
                          ? IconlyBold.home
                          : IconlyLight.home,
                    ),
                    label: "",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      obj.currentIndex == 1
                          ? IconlyBold.heart
                          : IconlyLight.heart,
                    ),
                    label: "",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      obj.currentIndex == 2 ? IconlyBold.buy : IconlyLight.buy,
                    ),
                    label: "",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      obj.currentIndex == 3
                          ? IconlyBold.profile
                          : IconlyLight.profile,
                    ),
                    label: "",
                  ),
                ],
              ),
            ),
            obj.isLoading
                ? Container(
                    width: Responsive.width * 100,
                    height: Responsive.height * 100,
                    color: Colors.black87,
                    child: Center(
                      child: SpinKitWaveSpinner(
                        color: AppColors.primary,
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        );
      },
    );
  }
}
