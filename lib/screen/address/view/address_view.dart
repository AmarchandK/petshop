import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constant/colors_file.dart';
import '../../../constant/common_widget.dart';
import '../../home/controller/home_controller.dart';
import '../controller/address_controller.dart';
import 'shipping_address.dart';

class AddressView extends StatefulWidget {
  const AddressView({super.key});

  @override
  State<AddressView> createState() => _AddressViewState();
}

class _AddressViewState extends State<AddressView> {
  final controller = Get.put(AddressController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (obj) {
        return Common.scaffold<AddressController>(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
              ),
            ),
            backgroundColor: Colors.white,
            title: Text(
              "Address",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: AppColors.primary,
              ),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Column(
                  children: [
                    Get.find<HomeController>()
                                .address
                                ?.shipping
                                ?.address1
                                ?.trim()
                                .isEmpty ==
                            true
                        ? addressItem(
                            title: 'Shipping Address',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ShippingAddressView(
                                    isShipping: true,
                                  ),
                                ),
                              );
                            },
                          )
                        : GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ShippingAddressView(
                                    data: obj.address?.shipping,
                                    isShipping: true,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 10,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: AppColors.primary,
                                  width: .5,
                                ),
                              ),
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Common.text(
                                        text: 'Shipping Address',
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      CircleAvatar(
                                        radius: 15,
                                        backgroundColor: AppColors.primary,
                                        child: Icon(
                                          Icons.edit,
                                          color: AppColors.whiteColor,
                                          size: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Common.smallSizedBox(),
                                  Common.text(
                                    text:
                                        'Deliver to ${obj.address?.shipping?.firstName} ${obj.address?.shipping?.lastName} ${obj.address?.shipping?.address1} ${obj.address?.shipping?.address2} ${obj.address?.shipping?.city} ${obj.address?.shipping?.postcode} ${obj.address?.shipping?.country}',
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                            ),
                          ),
                    Common.smallSizedBox(),
                    Get.find<HomeController>()
                                .address
                                ?.billing
                                ?.address1
                                ?.trim()
                                .isEmpty ==
                            true
                        ? addressItem(
                            title: 'Billing Address',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ShippingAddressView(
                                    isShipping: false,
                                  ),
                                ),
                              );
                            },
                          )
                        : GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ShippingAddressView(
                                    data: obj.address?.billing,
                                    isShipping: false,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 10,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: AppColors.primary,
                                  width: .5,
                                ),
                              ),
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Common.text(
                                        text: 'Billing Address',
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      CircleAvatar(
                                        radius: 15,
                                        backgroundColor: AppColors.primary,
                                        child: Icon(
                                          Icons.edit,
                                          color: AppColors.whiteColor,
                                          size: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Common.smallSizedBox(),
                                  Common.text(
                                    text:
                                        'Deliver to ${obj.address?.billing?.firstName} ${obj.address?.billing?.lastName} ${obj.address?.billing?.address1} ${obj.address?.billing?.address2} ${obj.address?.billing?.city} ${obj.address?.billing?.postcode} ${obj.address?.billing?.country} ${obj.address?.billing?.state} ${obj.address?.billing?.email} ${obj.address?.billing?.phone}',
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                            ),
                          ),
                    Common.smallSizedBox(),
                    const Text(
                      'The following addresses will be used on the checkout page by default.',
                    )
                  ],
                )),
          ),
        );
      },
    );
  }

  Container addressItem({required String title, required Function() onTap}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.primary,
          width: .5,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColors.primary,
                    ),
                  ),
                  const Text(
                    'You have not set up this type of address yet.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              )),
          Expanded(
            flex: 1,
            child: Common.button(
              text: 'Add',
              onPressed: onTap,
            ),
          )
        ],
      ),
    );
  }
}
