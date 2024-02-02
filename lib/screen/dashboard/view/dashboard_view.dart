import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import '../../../constant/colors_file.dart';
import '../../../constant/common_widget.dart';
import '../controller/dashboard_controller.dart';

class DashBoardView extends StatefulWidget {
  const DashBoardView({super.key});

  @override
  State<DashBoardView> createState() => _DashBoardViewState();
}

class _DashBoardViewState extends State<DashBoardView> {
  final controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Common.scaffold<DashboardController>(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios)),
          backgroundColor: Colors.white,
          title: Text(
            "DashBoard",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: AppColors.primary,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                //Navigator.push(context, MaterialPageRoute(builder: (context)=> const ()));
              },
              icon: const Icon(IconlyLight.profile),
            ),
          ],
        ),
        body: const SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: Text(
                  'From your account dashboard you can view your recent orders manage your shipping and billing addresses and credit your password and account details.',
                  textAlign: TextAlign.center,
                ))
              ],
            ),
          ),
        ));
  }
}
