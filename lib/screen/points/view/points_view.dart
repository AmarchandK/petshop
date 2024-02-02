import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';

import '../../../constant/colors_file.dart';
import '../../../constant/common_widget.dart';
import '../../../constant/routes.dart';
import '../controller/points_controller.dart';

class PointsView extends StatefulWidget {
  const PointsView({super.key});

  @override
  State<PointsView> createState() => _PointsViewState();
}

class _PointsViewState extends State<PointsView> {
  final controller = Get.put(PointsController());

  @override
  Widget build(BuildContext context) {
    return Common.scaffold<PointsController>(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Routes.back();
              },
              icon: const Icon(Icons.arrow_back_ios)),
          backgroundColor: Colors.white,
          title: Text(
            "Downloads",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: AppColors.primary,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                IconlyLight.activity,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    'Points balance',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: AppColors.primary,
                    ),
                  ),
                  subtitle: const Text('You have 0 points worth AED0.00.'),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    'Recent Events',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: AppColors.primary,
                    ),
                  ),
                  subtitle: const Text('You have not earned any points yet'),
                )
              ],
            ),
          ),
        ));
  }
}
