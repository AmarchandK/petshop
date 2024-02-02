import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import '../../../constant/colors_file.dart';
import '../../../constant/common_widget.dart';
import '../controller/account_details_controller.dart';

class AccountDetailsScreen extends StatefulWidget {
  const AccountDetailsScreen({super.key});

  @override
  State<AccountDetailsScreen> createState() => _AccountDetailsScreenState();
}

class _AccountDetailsScreenState extends State<AccountDetailsScreen> {
  final controller = Get.put(AccountDetailsController());
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _displayNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Common.scaffold<AccountDetailsController>(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        backgroundColor: Colors.white,
        title: Text(
          "Account Details",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: AppColors.primary,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(IconlyLight.profile),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Common.textFormField(
                  labelText: 'First Name*',
                  //prefixIcon: const Icon(Icons.search),
                  hintText: "John",
                  controller: _firstNameController,
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  validator: (_) {
                    return null;
                  },
                  onSaved: (_) {},
                  onChanged: (val) {},
                  context: context,
                ),
                Common.smallSizedBox(),
                Common.textFormField(
                  labelText: 'Last Name*',
                  //prefixIcon: const Icon(Icons.search),
                  hintText: "Doe",
                  controller: _lastNameController,
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  validator: (_) {
                    return null;
                  },
                  onSaved: (_) {},
                  onChanged: (val) {},
                  context: context,
                ),
                Common.smallSizedBox(),
                Common.textFormField(
                  labelText: 'Display Name*',
                  //prefixIcon: const Icon(Icons.search),
                  hintText: "John Doe",
                  controller: _displayNameController,
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  validator: (_) {
                    return null;
                  },
                  onSaved: (_) {},
                  onChanged: (val) {},
                  context: context,
                ),
                const Text(
                  'This will be how your name will be displayed in the account section and in reviews',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
                Common.smallSizedBox(),
                Common.textFormField(
                  labelText: 'Email Address*',
                  //prefixIcon: const Icon(Icons.search),
                  hintText: "example@email.com",
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  obscureText: false,
                  validator: (_) {
                    return null;
                  },
                  onSaved: (_) {},
                  onChanged: (val) {},
                  context: context,
                ),
                Common.smallSizedBox(),
                Common.commonText(text: 'Password Change'),
                const AutoSizeText(
                  'Current password( leave blank to leave unchanged )',
                  maxLines: 1,
                ),
                Common.textFormField(
                  maxLines: 1,
                  //labelText: 'Email Address*',
                  //prefixIcon: const Icon(Icons.search),
                  hintText: "",
                  controller: _currentPasswordController,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  validator: (_) {
                    return null;
                  },
                  onSaved: (_) {},
                  onChanged: (val) {},
                  context: context,
                ),
                Common.smallSizedBox(),
                const AutoSizeText(
                  'New password( leave blank to leave unchanged )',
                  maxLines: 1,
                ),
                Common.textFormField(
                  maxLines: 1,
                  //labelText: 'Email Address*',
                  //prefixIcon: const Icon(Icons.search),
                  hintText: "",
                  controller: _newPasswordController,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  validator: (_) {
                    return null;
                  },
                  onSaved: (_) {},
                  onChanged: (val) {},
                  context: context,
                ),
                Common.smallSizedBox(),
                const AutoSizeText(
                  'Confirm Password',
                  maxLines: 1,
                ),
                Common.textFormField(
                  maxLines: 1,
                  //labelText: 'Email Address*',
                  //prefixIcon: const Icon(Icons.search),
                  hintText: "",
                  controller: _confirmPasswordController,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  validator: (_) {
                    return null;
                  },
                  onSaved: (_) {},
                  onChanged: (val) {},
                  context: context,
                ),
                Common.smallSizedBox(),
                Common.button(text: 'Save Changes', onPressed: () {})
              ],
            )),
      ),
    );
  }
}
