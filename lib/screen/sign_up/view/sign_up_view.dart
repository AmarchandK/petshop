import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:petvillage/constant/colors_file.dart';
import 'package:petvillage/constant/common_widget.dart';
import 'package:petvillage/constant/responsive.dart';
import 'package:petvillage/screen/login/view/login_view.dart';
import 'package:petvillage/screen/sign_up/controller/signup_controller.dart';
import '../../../constant/const_string.dart';
import '../../../constant/routes.dart';

class SignUpStateView extends StatefulWidget {
  const SignUpStateView({super.key});

  @override
  State<SignUpStateView> createState() => _SignUpStateViewState();
}

class _SignUpStateViewState extends State<SignUpStateView> {
  final _signupController = Get.put(SignupController());
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: GetBuilder<SignupController>(builder: (obj) {
        return Common.scaffold<SignupController>(
          isLoading: _signupController.isLoading,
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
                    SizedBox(height: Responsive.height * 3),
                    Common.text(
                      text: "Register",
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                    SizedBox(height: Responsive.height * 1),
                    Common.text(
                      text: "User Name",
                      fontWeight: FontWeight.w400,
                      color: AppColors.primary,
                    ),
                    Common.textFormField(
                      context: context,
                      hintText: "",
                      controller: _userNameController,
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      suffixIcon: null,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your user name";
                        }
                        return null;
                      },
                      onSaved: (value) {},
                      onChanged: (value) {},
                    ),
                    SizedBox(height: Responsive.height * 1),
                    Common.text(
                      text: "Email Address",
                      fontWeight: FontWeight.w400,
                      color: AppColors.primary,
                    ),
                    Common.textFormField(
                      context: context,
                      hintText: "",
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      obscureText: false,
                      suffixIcon: null,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your email address";
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
                    ),
                    Common.textFormField(
                      maxLines: 1,
                      context: context,
                      hintText: "",
                      controller: _passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: false,
                      suffixIcon: null,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your password";
                        }
                        return null;
                      },
                      autoValidate: (value) {
                        debugPrint("autoValidate: $value");
                      },
                      onSaved: (value) {},
                      onChanged: (value) {},
                    ),
                    SizedBox(height: Responsive.height * 1),
                    Common.text(
                      text: "Confirm Password",
                      fontWeight: FontWeight.w400,
                      color: AppColors.primary,
                    ),
                    Common.textFormField(
                      maxLines: 1,
                      context: context,
                      hintText: "",
                      controller: _confirmPasswordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      suffixIcon: null,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your password";
                        }
                        return null;
                      },
                      autoValidate: (value) {
                        debugPrint("autoValidate: $value");
                      },
                      onSaved: (value) {},
                      onChanged: (value) {},
                    ),
                    SizedBox(height: Responsive.height * 3),
                    Common.button(
                      buttonHeight: 50,
                      fontSize: 20,
                      text: "Register",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final pas = _passwordController.text;
                          final conPas = _confirmPasswordController.text;
                          if (pas != conPas) {
                            Common.snackBar(
                              title: "Password not match",
                              message: "Please check your password",
                            );
                            return;
                          }
                          _signupController.signup(
                            email: _emailController.text,
                            password: _passwordController.text,
                            userName: _userNameController.text,
                          );
                        }
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          'Already a member?',
                          style: TextStyle(fontSize: 14),
                        ),
                        TextButton(
                          onPressed: () {
                            Routes.push(
                              screen: const LoginView(),
                              action: (_) {},
                            );
                          },
                          child: Text(
                            'Login',
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
      }),
    );
  }
}
