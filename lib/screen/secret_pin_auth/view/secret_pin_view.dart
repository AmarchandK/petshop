import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petvillage/constant/colors_file.dart';
import 'package:petvillage/constant/common_widget.dart';
import 'package:petvillage/constant/responsive.dart';
import 'package:petvillage/screen/change_password/view/change_password_view.dart';
import 'package:petvillage/screen/login/controller/login_controller.dart';
import 'package:pinput/pinput.dart';
import '../../../constant/const_string.dart';

class SecretPinView extends StatefulWidget {
  const SecretPinView({super.key});

  @override
  State<SecretPinView> createState() => _SecretPinViewState();
}

class _SecretPinViewState extends State<SecretPinView> {
  final _formKey = GlobalKey<FormState>();

  String errorText = "Password or username is incorrect";
  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Common.scaffold(
      body: SingleChildScrollView(
        padding: Common.kPadding,
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Responsive.height * 2),
                const Center(
                  child: Image(
                    image: AssetImage(
                      ConstString.petLogo,
                    ),
                    height: 140,
                  ),
                ),
                SizedBox(height: Responsive.height * 4),
                Center(
                  child: Common.text(
                      text: "Enter code sent to your email",
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                      textAlign: TextAlign.center),
                ),
                SizedBox(height: Responsive.height * 2),
                Center(
                  child: Pinput(
                    validator: (s) {
                      // print('$s ----s');
                      // print(loginController.randomNumber.value.toString());
                      return s == loginController.randomNumber.value.toString()
                          ? null
                          : 'Pin is incorrect';
                    },
                    pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                    showCursor: true,
                    // onCompleted: (pin) => print(pin),
                  ),
                ),
                SizedBox(height: Responsive.height * 2),
                Common.button(
                  buttonHeight: 50,
                  fontSize: 20,
                  text: "Confirm",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Get.to(const ChangePasswordView());
                    }
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'Resend code',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 18
                          
                        ),
                        children: [
                          TextSpan(
                            text: ' Resend',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: AppColors.lightBlue,
                              fontSize: 16
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => loginController.sendMail(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Common.extraSmallSizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
