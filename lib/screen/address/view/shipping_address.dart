import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:petvillage/screen/address/controller/address_controller.dart';
import 'package:petvillage/screen/home/model/address_model.dart';
import '../../../constant/colors_file.dart';
import '../../../constant/common_widget.dart';

class ShippingAddressView extends StatefulWidget {
  const ShippingAddressView({super.key, this.data, required this.isShipping});
  final Ing? data;
  final bool isShipping;
  @override
  State<ShippingAddressView> createState() => _ShippingAddressViewState();
}

class _ShippingAddressViewState extends State<ShippingAddressView> {
  final controller = Get.put(AddressController());
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _countryController = TextEditingController(
    text: 'United Arab Emirates',
  );
  final _companyController = TextEditingController();
  final _addressOne = TextEditingController();
  final _addressTwo = TextEditingController();
  final _emailAddress = TextEditingController();
  final _phoneNumber = TextEditingController();
  final _pinCodeController = TextEditingController();
  final _cityController = TextEditingController();
  String country = '';

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.data != null) {
      _firstNameController.text = widget.data?.firstName ?? '';
      _lastNameController.text = widget.data?.lastName ?? '';
      _companyController.text = widget.data?.company ?? '';
      _addressOne.text = widget.data?.address1 ?? '';
      _addressTwo.text = widget.data?.address2 ?? '';
      _emailAddress.text = widget.data?.email ?? '';
      _phoneNumber.text = widget.data?.phone ?? '';
      _countryController.text = widget.data?.country ?? 'United Arab Emirates';
      _pinCodeController.text = widget.data?.postcode ?? "";
      _cityController.text = widget.data?.city ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddressController>(
      builder: (obj) {
        return Common.scaffold<AddressController>(
          isLoading: obj.isLoading,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
            backgroundColor: Colors.white,
            title: Text(
              widget.isShipping ? "Shipping Address" : "Billing Address",
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
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Common.textFormField(
                      labelText: 'First Name*',
                      hintText: "John",
                      controller: _firstNameController,
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      onSaved: (_) {},
                      onChanged: (val) {},
                      context: context,
                    ),
                    Common.smallSizedBox(),
                    Common.textFormField(
                      labelText: 'Last Name*',
                      hintText: "Doe",
                      controller: _lastNameController,
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      onSaved: (_) {},
                      onChanged: (val) {},
                      context: context,
                    ),
                    Common.smallSizedBox(),
                    Common.textFormField(
                      onTap: () {},
                      labelText: 'Country/Region*',
                      hintText: "",
                      controller: _countryController,
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      onSaved: (_) {},
                      onChanged: (val) {},
                      context: context,
                    ),
                    Common.smallSizedBox(),
                    Common.textFormField(
                      labelText: 'Company Name (Optional)',
                      hintText: "Pet Village",
                      controller: _companyController,
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      onSaved: (_) {},
                      onChanged: (val) {},
                      context: context,
                    ),
                    Common.smallSizedBox(),
                    Common.textFormField(
                      labelText: 'Address 1*',
                      hintText: "",
                      controller: _addressOne,
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      onSaved: (_) {},
                      onChanged: (val) {},
                      context: context,
                    ),
                    Common.smallSizedBox(),
                    Common.textFormField(
                      labelText: 'Address 2 (Optional)',
                      hintText: "",
                      controller: _addressTwo,
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      onSaved: (_) {},
                      onChanged: (val) {},
                      context: context,
                    ),
                    Common.smallSizedBox(),
                    Common.textFormField(
                      labelText: 'City*',
                      hintText: "",
                      controller: _cityController,
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      onSaved: (_) {},
                      onChanged: (val) {},
                      context: context,
                    ),
                    Common.smallSizedBox(),
                    Common.textFormField(
                      labelText: 'Pincode *',
                      hintText: "",
                      controller: _pinCodeController,
                      keyboardType: TextInputType.number,
                      obscureText: false,
                      onSaved: (_) {},
                      onChanged: (val) {},
                      context: context,
                    ),
                    Common.smallSizedBox(),
                    Visibility(
                      visible: !widget.isShipping,
                      child: Column(
                        children: [
                          Common.textFormField(
                            labelText: 'Email Address*',
                            hintText: "petvillage@mail.ae",
                            controller: _emailAddress,
                            keyboardType: TextInputType.emailAddress,
                            obscureText: false,
                            onSaved: (_) {},
                            onChanged: (val) {},
                            context: context,
                          ),
                          Common.smallSizedBox(),
                          Common.textFormField(
                            labelText: 'Phone number*',
                            hintText: "",
                            controller: _phoneNumber,
                            keyboardType: TextInputType.number,
                            obscureText: false,
                            onSaved: (_) {},
                            onChanged: (val) {},
                            context: context,
                          ),
                          Common.smallSizedBox(),
                        ],
                      ),
                    ),
                    Common.button(
                      text: 'Save Address',
                      onPressed: () {
                        if (widget.isShipping) {
                          if (_countryController.text.isEmpty ||
                              _addressOne.text.isEmpty ||
                              _lastNameController.text.isEmpty ||
                              _firstNameController.text.isEmpty ||
                              _pinCodeController.text.isEmpty ||
                              _cityController.text.isEmpty) {
                            Common.snackBar(
                              title: "Fill all details",
                              message: "Please fill all details",
                              backgroundColor: Colors.red,
                            );
                            return;
                          }
                        } else {
                          if (_countryController.text.isEmpty ||
                              _addressOne.text.isEmpty ||
                              _lastNameController.text.isEmpty ||
                              _firstNameController.text.isEmpty ||
                              _emailAddress.text.isEmpty ||
                              _phoneNumber.text.isEmpty ||
                              _pinCodeController.text.isEmpty ||
                              _cityController.text.isEmpty) {
                            Common.snackBar(
                              title: "Fill all details",
                              message: "Please fill all details",
                              backgroundColor: Colors.red,
                            );
                            return;
                          }
                        }
                        controller.updateAddress(
                          type: widget.isShipping
                              ? "shipping_address"
                              : "billing_address",
                          address: Ing(
                            firstName: _firstNameController.text,
                            lastName: _lastNameController.text,
                            company: _companyController.text.trim().isEmpty
                                ? "-"
                                : _companyController.text,
                            address1: _addressOne.text,
                            address2: _addressTwo.text.trim().isEmpty
                                ? "-"
                                : _addressTwo.text,
                            city: _cityController.text,
                            country: _countryController.text,
                            email: _emailAddress.text.trim().isEmpty
                                ? "-"
                                : _emailAddress.text,
                            phone: _phoneNumber.text.trim().isEmpty
                                ? "-"
                                : _phoneNumber.text,
                            postcode: _pinCodeController.text,
                            state: "Dubai",
                          ),
                        );
                      },
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
