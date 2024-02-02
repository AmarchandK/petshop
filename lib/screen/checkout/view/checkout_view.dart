import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constant/colors_file.dart';
import '../../../constant/common_widget.dart';
import '../../../constant/responsive.dart';
import '../controller/checkout_controller.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key});

  @override
  State<CheckoutView> createState() => _CartViewState();
}

class _CartViewState extends State<CheckoutView> {
  final _couponController = TextEditingController();
  final controller = Get.put(CheckoutController());
  late int selectedRadio;
  bool _isChecked = false;

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Common.scaffold<CheckoutController>(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {}, icon: const Icon(Icons.arrow_back_ios)),
        backgroundColor: Colors.white,
        title: Text(
          "Checkout",
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
              Common.commonText(text: 'Coupon Code'),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Common.textFormField(
                      //prefixIcon: const Icon(Icons.search),
                      hintText: "ABCD",
                      controller: _couponController,
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      validator: (_) {
                        return null;
                      },
                      onSaved: (_) {},
                      onChanged: (val) {},
                      context: context,
                    ),
                  ),
                  Expanded(child: SizedBox(width: Responsive.width * 2)),
                  Expanded(
                      flex: 2,
                      child: Common.button(text: 'Apply', onPressed: () {})),
                  Common.largeSizedBox(),
                ],
              ),
              Common.divider(),
              Text(
                'Your Order',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: AppColors.primary),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text(
                  'Happy Dog MiniXS Japan 1.3 Kg × 1 ',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: AutoSizeText(
                  'AED 10.00',
                  maxLines: 1,
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text(
                  'Subtotal',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: AutoSizeText(
                  'AED 10.00',
                  maxLines: 1,
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
              Common.divider(),
              ListTile(
                contentPadding: const EdgeInsets.all(0),
                title: Text(
                  'Shipping',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: AppColors.primary),
                ),
                subtitle: const Text('Shipping fee'),
                trailing: AutoSizeText(
                  'AED 10.00',
                  maxLines: 1,
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
              Common.divider(),
              ListTile(
                contentPadding: const EdgeInsets.all(0),
                title: Text(
                  'VAT',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: AppColors.primary),
                ),
                trailing: AutoSizeText(
                  'AED 1.6',
                  maxLines: 1,
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
              Common.divider(),
              ListTile(
                contentPadding: const EdgeInsets.all(0),
                title: Text(
                  'Total',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: AppColors.primary),
                ),
                trailing: AutoSizeText(
                  'AED 51.6',
                  maxLines: 1,
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
              Common.divider(),
              Text(
                'Payment Method',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: AppColors.primary),
              ),
              RadioListTile(
                contentPadding: EdgeInsets.zero,
                value: 1,
                groupValue: selectedRadio,
                title: Text(
                  "Pay on delivery",
                  style: TextStyle(
                    fontSize: 15,
                    color: AppColors.primary,
                  ),
                ),
                subtitle: const Text("Pay with Cash/Card upon delivery"),
                onChanged: (val) {
                  //print("Radio Tile pressed $val");
                  setSelectedRadio(val!);
                },
                activeColor: AppColors.primary,
                selected: true,
              ),
              RadioListTile(
                contentPadding: EdgeInsets.zero,
                value: 2,
                groupValue: selectedRadio,
                title: Text(
                  "Credit/Debit Card(Stripe)",
                  style: TextStyle(
                    fontSize: 15,
                    color: AppColors.primary,
                  ),
                ),
                onChanged: (val) {
                  //print("Radio Tile pressed $val");
                  setSelectedRadio(val!);
                },
                activeColor: AppColors.primary,
                //selected: false,
              ),
              Common.smallSizedBox(),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text:
                          'If you don’t see an order confirmation email from us, please check your spam folder and that the email address above is correct.',
                      style: TextStyle(color: AppColors.primary),
                    ),
                    const TextSpan(
                      text:
                          ' Your personal data will be used to process your order, support your experience throughout this website, and for other purposes described in our ',
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: 'Privacy Policy.',
                      style: TextStyle(
                        color: AppColors.primary,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          launchUrl(
                              Uri.parse('https://example.com/privacy-policy'));
                        },
                    ),
                  ],
                ),
              ),
              CheckboxListTile(
                activeColor: AppColors.primary,
                checkColor: Colors.white,
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
                title: InkWell(
                  onTap: () {
                    launchUrl(Uri.parse('https://example.com/privacy-policy'));
                  },
                  child: RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: 'I have read and agree to the ',
                          style: TextStyle(color: Colors.black),
                        ),
                        TextSpan(
                          text: 'Terms and conditions.',
                          style: TextStyle(
                            color: AppColors.primary,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              launchUrl(Uri.parse(
                                  'https://example.com/privacy-policy'));
                            },
                        ),
                      ],
                    ),
                  ),
                ),
                value: _isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    _isChecked = value!;
                  });
                },
              ),
              Common.smallSizedBox(),
              Common.button(text: 'Place Order', onPressed: () {})
            ],
          ),
        ),
      ),
    );
  }
}
