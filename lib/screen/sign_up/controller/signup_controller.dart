import 'package:get/get.dart';
import 'package:petvillage/constant/const_string.dart';
import 'package:petvillage/screen/sign_up/service/signup_service.dart';

class SignupController extends GetxController {
  bool isLoading = false;
  bool isErrorMessage = false;
  Future<void> signup(
      {required String userName,
      required String email,
      required String password}) async {
    try {
      isLoading = true;
      isErrorMessage = false;
      update();
      await ConstString.setName(name: userName);
      await SignupService.signup(body: {
        "customer": {
          "email": email,
          "username": userName,
          "password": password,
        }
      });
    } finally {
      isLoading = false;
      update();
    }
  }
}
