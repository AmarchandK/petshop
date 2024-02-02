import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:petvillage/constant/const_string.dart';
import 'package:petvillage/screen/login/view/login_view.dart';
import 'package:petvillage/screen/nav/view/nav_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    goNext();
  }

  void goNext() async {
    bool? login = await ConstString.getLogin(ConstString.isLogin);
    await Future.delayed(const Duration(seconds: 2));
    if (login == true) {
      Get.offAll(() => const NavView());
    } else {
      Get.offAll(() => const LoginView());
    }
  }

  @override
  Widget build(BuildContext context) {
    return const AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: Center(
          child: Image(
            image: AssetImage(
              ConstString.petLogo,
            ),
            height: 190,
          ),
        ),
      ),
    );
  }
}
