import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'constant/responsive.dart';
import 'constant/routes.dart';
import 'firebase_options.dart';
import 'screen/splash/view/splash_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      "pk_test_51N2roFBLjVXVMSq1wSrIbsGnH7XKh9i6FPgdIqLeFkvN5L3GpOnUiafZzCOaKMK3iBME7NeDUAzjZEvBpv37yUHs00iHd6GuE0";
  await Stripe.instance.applySettings();
  Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        Responsive().init(constraints, orientation);
        return GetMaterialApp(
          navigatorKey: Routes.key,
          debugShowCheckedModeBanner: false,
          home: const SplashView(),
        );
      });
    });
  }
}
