import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petvillage/constant/colors_file.dart';
import 'package:petvillage/constant/common_widget.dart';
import 'package:petvillage/constant/responsive.dart';
import '../../../constant/const_string.dart';
import '../../sign_up/view/sign_up_view.dart';
import '../controller/login_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _loginController = Get.put(LoginController());
  String errorText = "Password or username is incorrect";

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (obj) {
        return Common.scaffold<LoginController>(
          isLoading: _loginController.isLoading,
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
                      text: "Log In",
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                    SizedBox(height: Responsive.height * 2),
                    Common.text(
                      text: "User name or email Address",
                      fontWeight: FontWeight.w400,
                      color: AppColors.primary,
                      fontSize: 14,
                    ),
                    SizedBox(height: Responsive.height * .5),
                    Common.textFormField(
                      context: context,
                      hintText: "",
                      controller: _userNameController,
                      keyboardType: TextInputType.emailAddress,
                      obscureText: false,
                      suffixIcon: null,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your user name or email address";
                        }
                        return null;
                      },
                      onSaved: (value) {},
                      onChanged: (value) {},
                    ),
                    SizedBox(height: Responsive.height * 1),
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
                          controller: _passwordController,
                          keyboardType: TextInputType.text,
                          obscureText: !_loginController.isPasswordVisible,
                          validator: (value) {
                            if (value!.isEmpty) {
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
                    Visibility(
                      visible: _loginController.isErrorMessage,
                      child: Center(
                        child: Text(
                          errorText,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        GetBuilder<LoginController>(builder: (obj) {
                          return Checkbox(
                            activeColor: AppColors.primary,
                            value: _loginController.isPasswordRemember,
                            onChanged: (value) {
                              _loginController.onRememberPassword(value!);
                            },
                          );
                        }),
                        Common.text(
                          text: "Remember me",
                          fontWeight: FontWeight.w400,
                          color: AppColors.primary,
                        ),
                        const Spacer(),
                        Common.text(
                          text: "Forgot Password?",
                          fontWeight: FontWeight.w400,
                          color: AppColors.primary,
                        ),
                      ],
                    ),
                    Common.button(
                      buttonHeight: 50,
                      fontSize: 20,
                      text: "Log In",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _loginController.login(
                            user: _userNameController.text,
                            pas: _passwordController.text,
                          );
                        }
                      },
                    ),
                    Common.extraSmallSizedBox(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          'Not a member?',
                          style: TextStyle(fontSize: 14),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.to(() => const SignUpStateView());
                          },
                          child: Text(
                            'Register',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
