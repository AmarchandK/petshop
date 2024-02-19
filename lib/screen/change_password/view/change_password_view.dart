import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petvillage/constant/colors_file.dart';
import 'package:petvillage/constant/common_widget.dart';
import 'package:petvillage/constant/responsive.dart';
import 'package:petvillage/screen/change_password/controller/change_password_controller.dart';
import 'package:petvillage/screen/login/controller/login_controller.dart';
import '../../../constant/const_string.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _loginController = Get.put(LoginController());
  final changepasswordController = Get.put(ChangepasswordController());

  String errorText = "Password or username is incorrect";

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
                Common.text(
                  text: "Enter code sent to your email",
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
                Common.text(
                  text: "Password",
                  fontWeight: FontWeight.w400,
                  color: AppColors.primary,
                  fontSize: 14,
                ),
                SizedBox(height: Responsive.height * .5),
                GetBuilder<LoginController>(
                  builder: (obj) {
                    return TextFormField(
                      onTap: () {
                        _loginController.onPasswordVisibility();
                      },
                      controller:
                          changepasswordController.newPasswordController,
                      keyboardType: TextInputType.text,
                      obscureText: !_loginController.isPasswordVisible,
                      validator: (value) {
                        if (value!.isEmpty) {
                          obj.isForgot.value = true;

                          return "Please enter your password";
                        }
                        return null;
                      },
                      onSaved: (value) {},
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: Responsive.width * 3,
                        ),
                        labelStyle: TextStyle(color: AppColors.primary),
                        hintText: "Password",
                        hintStyle: TextStyle(
                          fontSize: 14,
                          fontFamily: GoogleFonts.tajawal().fontFamily,
                          fontWeight: FontWeight.w600,
                          color: AppColors.blackColor.withOpacity(0.7),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            _loginController.onPasswordVisibility();
                          },
                          icon: Icon(
                            _loginController.isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AppColors.primary,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(
                            color: AppColors.blackColor,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(
                            color: AppColors.blackColor,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Common.extraSmallSizedBox(),
                Common.text(
                  text: "New Password",
                  fontWeight: FontWeight.w400,
                  color: AppColors.primary,
                  fontSize: 14,
                ),
                SizedBox(height: Responsive.height * .5),
                GetBuilder<LoginController>(
                  builder: (obj) {
                    return TextFormField(
                      onTap: () {
                        _loginController.onPasswordVisibility();
                      },
                      controller:
                          changepasswordController.reEnteredPasswordController,
                      keyboardType: TextInputType.text,
                      obscureText: !_loginController.isPasswordVisible,
                      validator: (value) {
                        if (value!.isEmpty) {
                          obj.isForgot.value = true;

                          return "Please enter your password";
                        } else if (changepasswordController
                                .newPasswordController.text !=
                            changepasswordController
                                .reEnteredPasswordController.text) {
                          return "Your password is mismatching";
                        }

                        return null;
                      },
                      onSaved: (value) {},
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: Responsive.width * 3,
                        ),
                        labelStyle: TextStyle(color: AppColors.primary),
                        hintText: "Re-Enter Password",
                        hintStyle: TextStyle(
                          fontSize: 14,
                          fontFamily: GoogleFonts.tajawal().fontFamily,
                          fontWeight: FontWeight.w600,
                          color: AppColors.blackColor.withOpacity(0.7),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(
                            color: AppColors.blackColor,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(
                            color: AppColors.blackColor,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Common.extraSmallSizedBox(),
                SizedBox(height: Responsive.height * 2),
                GetBuilder<LoginController>(
                  builder: (controller) => Common.button(
                    buttonHeight: 50,
                    fontSize: 20,
                    text: "Confirm",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        controller.forgotPassword(
                            controller.address?.id.toString(),
                            changepasswordController
                                .newPasswordController.text);
                      }
                    },
                  ),
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
