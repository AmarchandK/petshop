import 'package:get/get.dart';
import 'package:petvillage/constant/const_string.dart';
import '../service/login_service.dart';

class LoginController extends GetxController {
  bool isPasswordRemember = false;
  bool isLoading = false;
  bool isErrorMessage = false;

  void onRememberPassword(bool value) {
    isPasswordRemember = value;
    update();
  }

  void forgotPassword() async {
    final String? uid = await ConstString.getId();
    if (uid != null) {
      LoginService.forgotPassword( uid: uid, body: {});
      update();
    }
  }

  Future<void> login({required String user, required String pas}) async {
    try {
      isLoading = true;
      isErrorMessage = false;
      update();
      await LoginService.login(body: {
        "username": user,
        "password": pas,
      }).onError((error, stackTrace) => isErrorMessage = true);
    } finally {
      isLoading = false;
      update();
    }
  }

  bool isPasswordVisible = false;
  void onPasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    update();
  }
}
