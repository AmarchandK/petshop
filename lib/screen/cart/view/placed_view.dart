import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../nav/controller/nav_controller.dart';

class PlacedView extends StatefulWidget {
  const PlacedView({super.key});

  @override
  State<PlacedView> createState() => _PlacedViewState();
}

class _PlacedViewState extends State<PlacedView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Get.find<NavController>().changePage(0);
      Get.back();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/icon/success.json',
              height: 300,
            ),
            const Text(
              'Your order has been placed',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Thank you for shopping with us',
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 70),
          ],
        ),
      ),
    );
  }
}
