import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petvillage/constant/colors_file.dart';
import 'package:petvillage/constant/responsive.dart';

class Common {
  static final kPadding = EdgeInsets.symmetric(
    horizontal: Responsive.width * 6,
    vertical: Responsive.height * 3,
  );

  static Widget text({
    required String text,
    double? fontSize,
    FontWeight? fontWeight,
    TextAlign? textAlign,
    double? letterSpacing,
    Color? color,
    String? fontFamily,
    bool isLineThrough = false,
    int? maxLines,
    double? height,
  }) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      style: TextStyle(
        height: height,
        fontSize: fontSize ?? 16,
        fontFamily: fontFamily ?? GoogleFonts.tajawal().fontFamily,
        fontWeight: fontWeight ?? FontWeight.w600,
        letterSpacing: letterSpacing,
        color: color ?? AppColors.blackColor,
        decoration: isLineThrough ? TextDecoration.lineThrough : null,
      ),
    );
  }

  static Widget textFormField({
    required String hintText,
    String? labelText,
    required TextEditingController controller,
    required TextInputType keyboardType,
    required bool obscureText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    String? Function(String?)? validator,
    void Function(String?)? onSaved,
    void Function(String?)? onChanged,
    required BuildContext context,
    void Function(String?)? autoValidate,
    void Function()? onTap,
    int? maxLines,
    bool? readOnly,
    bool autoFocus = false,
  }) {
    return TextFormField(
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      autofocus: autoFocus,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      onSaved: onSaved,
      onChanged: onChanged,
      maxLines: maxLines,
      readOnly: readOnly == null ? false : true,
      onTap: onTap,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          horizontal: Responsive.width * 3,
        ),
        labelText: labelText,
        labelStyle: TextStyle(color: AppColors.primary),
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 14,
          fontFamily: GoogleFonts.tajawal().fontFamily,
          fontWeight: FontWeight.w600,
          color: AppColors.blackColor.withOpacity(0.7),
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(
            color: AppColors.blackColor,
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
  }

  static Widget button({
    required String text,
    required void Function()? onPressed,
    double? fontSize,
    FontWeight? fontWeight,
    Color? buttonColor,
    Color? textColor,
    double? buttonWidth,
    double? buttonHeight,
    double? radius,
    double? elevation,
  }) {
    return SizedBox(
      width: buttonWidth ?? double.infinity,
      height: buttonHeight ?? Responsive.height * 6.5,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: elevation,
          backgroundColor: buttonColor ?? AppColors.primary,
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.width * 6,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 4),
          ),
        ),
        child: Common.text(
          text: text,
          fontSize: fontSize ?? 16,
          fontWeight: fontWeight ?? FontWeight.w600,
          color: textColor ?? AppColors.whiteColor,
        ),
      ),
    );
  }

  static Widget scaffold<T extends GetxController>({
    PreferredSizeWidget? appBar,
    required Widget body,
    Widget? bottomNavigationBar,
    Widget? floatingActionButton,
    Widget? bottomSheet,
    FloatingActionButtonLocation? floatingActionButtonLocation,
    FloatingActionButtonAnimator? floatingActionButtonAnimator,
    Color? backgroundColor,
    bool? resizeToAvoidBottomInset,
    bool isLoading = false,
    Color? statusBarColor,
    Brightness? brightness,
    Color? navigationBarColor,
    Widget? drawer,
    Key? key,
  }) {
    return Stack(
      children: [
        AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: statusBarColor ?? Colors.transparent,
            statusBarIconBrightness: brightness ?? Brightness.dark,
            systemNavigationBarColor: navigationBarColor ?? Colors.transparent,
            systemNavigationBarIconBrightness: brightness ?? Brightness.dark,
          ),
          child: Scaffold(
            key: key,
            endDrawer: drawer,
            backgroundColor: backgroundColor ?? AppColors.whiteColor,
            appBar: appBar,
            body: body,
            bottomNavigationBar: bottomNavigationBar,
            floatingActionButton: floatingActionButton,
            floatingActionButtonLocation: floatingActionButtonLocation,
            floatingActionButtonAnimator: floatingActionButtonAnimator,
            resizeToAvoidBottomInset: resizeToAvoidBottomInset,
            bottomSheet: bottomSheet,
          ),
        ),
        isLoading
            ? Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: SpinKitPulse(
                    color: AppColors.primary,
                    size: 50,
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  static Widget divider({double? opacity}) {
    return Divider(
      thickness: 1,
      color: Colors.black.withOpacity(opacity ?? 1),
    );
  }

  static Widget extraSmallSizedBox() {
    return SizedBox(height: Responsive.height * .5);
  }

  static Widget smallSizedBox() {
    return SizedBox(height: Responsive.height * 2);
  }

  static Widget mediumSizedBox() {
    return SizedBox(height: Responsive.height * 5);
  }

  static Widget largeSizedBox() {
    return SizedBox(height: Responsive.height * 10);
  }

  static Text commonText({required String text}) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 20,
        color: AppColors.primary,
      ),
    );
  }

  static OutlinedButton commonOutlinedButton({
    required String text,
    required Function() onTap,
  }) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          color: AppColors.primary,
          width: 2.0,
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }

  static snackBar({
    required String title,
    required String message,
    Color? backgroundColor,
  }) {
    Get.closeAllSnackbars();
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: backgroundColor ?? AppColors.primary,
      colorText: AppColors.whiteColor,
      margin: EdgeInsets.symmetric(
        horizontal: Responsive.width * 6,
        vertical: Responsive.height * 2,
      ),
    );
  }

  static ListTile drawerListTile({
    required String text,
    required IconData? iconData,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.only(left: Responsive.width * 6),
      leading: Icon(
        iconData,
        color: AppColors.greenColor,
      ),
      title: drawerText(text),
      trailing: IconButton(
        onPressed: onTap,
        icon: Icon(
          Icons.arrow_forward_ios_sharp,
          color: AppColors.greyColor,
          size: 16,
        ),
      ),
    );
  }

  static ListTile drawerListTileWithoutIcon({
    required String text,
    void Function()? onTap,
  }) {
    return ListTile(
      onTap: onTap,
      title: drawerText(text),
      trailing: Visibility(
        visible: onTap == null ? false : true,
        child: IconButton(
          onPressed: onTap,
          icon: Icon(
            Icons.arrow_forward_ios_sharp,
            color: AppColors.greyColor,
            size: 16,
          ),
        ),
      ),
    );
  }

  static Text drawerText(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    );
  }

  static ListTile contactUsListTile(
      {required String text,
      required IconData iconData,
      required VoidCallback onPressed}) {
    return ListTile(
      onTap: onPressed,
      title: Text(
        text,
        maxLines: 2,
        style: TextStyle(
          color: AppColors.textColor,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
      leading: Icon(iconData, color: AppColors.greenColor),
    );
  }

  static Expanded drawerIcon({
    required VoidCallback onPressed,
    required IconData iconData,
  }) =>
      Expanded(
        child: IconButton(
          onPressed: onPressed,
          icon: Icon(
            iconData,
            size: 20,
            weight: 5,
          ),
          color: Colors.white,
        ),
      );
}
