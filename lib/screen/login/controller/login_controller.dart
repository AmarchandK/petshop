import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:petvillage/constant/const_string.dart';
import '../service/login_service.dart';

class LoginController extends GetxController {
  bool isPasswordRemember = false;
  bool isLoading = false;
  RxBool isErrorMessage = false.obs;
  RxBool isForgot = false.obs;
    final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final Random _random = Random();
  final RxInt randomNumber = 0.obs;
  

  void generateRandomNumber() {
    
   randomNumber.value = _random.nextInt(9000) + 1000;
    update();
  }
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
      isErrorMessage.value = false;
      update();
      await LoginService.login(body: {
        "username": user,
        "password": pas,
      }).onError((error, stackTrace) => isErrorMessage.value = true);
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
void sendMail() async {
generateRandomNumber();

String username = 'binuprasad2000@gmail.com';
String password = 'adhzcatlwmmzxahz';

  final smtpServer = gmail(username, password);
  final equivalentMessage = Message()
  ..from = Address(username, 'Pet shop')
  ..recipients.add(userNameController.text)
  // ..ccRecipients.addAll([Address(userNameController.text), userNameController.text])
  // ..bccRecipients.add(userNameController.text)
  ..subject = 'Reset  password :: 😀 :: ${DateTime.now()}'
  ..text = 'This is your verification number:${randomNumber.value.toString()}';
  // ..html = "<h1>Test</h1>\n<p>This is pet shop reset password</p>";
  update();
  try{
  print('succes');
print('$randomNumber randum');
  await send(equivalentMessage, smtpServer);

  }catch(e){
    if(kDebugMode){
      print(e.toString());
    }
  }

  }
}
