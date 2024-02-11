import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petvillage/screen/cart/model/cart_item.dart';
import 'package:petvillage/screen/home/controller/home_controller.dart';
import '../../../constant/colors_file.dart';
import '../../../constant/common_widget.dart';
import '../../../constant/responsive.dart';
import '../../address/view/address_view.dart';
import '../controller/cart_controller.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final controller = Get.find<CartController>();
  final homeController = Get.put(HomeController());
  String country = '';
  String userId = '';

  @override
  void initState() {
    super.initState();
    userId = homeController.userId;
    controller.getCartItems();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      builder: (obj) {
        return Common.scaffold<CartController>(
          isLoading: obj.isCartLoading,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              "Cart",
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("cart")
                        .doc(userId)
                        .collection("items")
                        .snapshots(),
                    builder: (context, snap) {
                      if (snap.connectionState == ConnectionState.waiting) {
                        return SizedBox(
                          height: Responsive.height * 80,
                          width: double.infinity,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      final cartItems =
                          controller.getCartItems(snap: snap.data);
                      if (cartItems.isEmpty) {
                        return SizedBox(
                          height: Responsive.height * 70,
                          child: const Center(
                            child: Text(
                              'No Items in Cart',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      }
                      return Column(
                        children: [
                          const Divider(),
                          const SizedBox(height: 10),
                          GetBuilder<HomeController>(
                            builder: (obj) {
                              return obj.address?.shipping?.firstName
                                              ?.trim()
                                              .isEmpty ==
                                          true ||
                                      obj.address?.billing?.firstName
                                              ?.trim()
                                              .isEmpty ==
                                          true
                                  ? Row(
                                      children: [
                                        Expanded(
                                          child: Common.text(
                                            text: "Add Address",
                                            fontWeight: FontWeight.bold,
                                            maxLines: 2,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            Get.to(() => const AddressView());
                                          },
                                          icon: Icon(
                                            Icons.add,
                                            color: AppColors.primary,
                                          ),
                                        ),
                                      ],
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Common.text(
                                            text:
                                                "Deliver to ${obj.address?.shipping?.firstName} ${obj.address?.shipping?.address1} ${obj.address?.shipping?.city} ${obj.address?.billing?.phone} ${obj.address?.billing?.email}",
                                            fontWeight: FontWeight.bold,
                                            maxLines: 2,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            Get.to(() => const AddressView());
                                          },
                                          icon: Icon(
                                            Icons.arrow_drop_down,
                                            color: AppColors.primary,
                                          ),
                                        ),
                                      ],
                                    );
                            },
                          ),
                          const SizedBox(height: 10),
                          const Divider(),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: cartItems.length,
                            itemBuilder: (context, index) {
                              final item = cartItems[index];
                              return CartItem(
                                item: item,
                                controller: controller,
                                userId: userId,
                              );
                            },
                          ),
                          Common.mediumSizedBox(),
                          Divider(
                            color: AppColors.primary,
                            thickness: .5,
                          ),
                          Common.mediumSizedBox(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Subtotal',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: AppColors.primary,
                                ),
                              ),
                              AutoSizeText(
                                'AED ${obj.subTotalAmount}',
                                maxLines: 1,
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: Responsive.height * 1),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Shipping Charge',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: AppColors.primary,
                                ),
                              ),
                              AutoSizeText(
                                'AED 10.00',
                                maxLines: 1,
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: Responsive.height * 1),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'VAT',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: AppColors.primary,
                                ),
                              ),
                              AutoSizeText(
                                'AED 1.60',
                                maxLines: 1,
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: Responsive.height * 1),
                          Divider(
                            color: AppColors.primary,
                            thickness: .5,
                          ),
                          SizedBox(height: Responsive.height * 1),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: AppColors.primary,
                                ),
                              ),
                              AutoSizeText(
                                'AED ${(obj.subTotalAmount + 11.6).round()}.0',
                                maxLines: 1,
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: Responsive.height * 3),
                          Common.button(
                            text: 'Proceed to Checkout',
                            onPressed: () {
                              int total =
                                  ((obj.subTotalAmount + 11.6).round() * 100)
                                      .toInt();
                              controller.createPaymentIntent(
                                price: total.toString(),
                                cartItems: cartItems,
                              );
                            },
                          ),
                          SizedBox(height: Responsive.height * 3),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class CartItem extends StatefulWidget {
  const CartItem({
    super.key,
    required this.item,
    required this.controller,
    required this.userId,
  });
  final CartItemModel item;
  final CartController controller;
  final String userId;
  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.primary,
          width: 2,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: widget.item.image,
            height: 100,
            width: 100,
            fit: BoxFit.cover,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          SizedBox(width: Responsive.width * 3),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    widget.item.name,
                    maxLines: 3,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primary,
                    ),
                  ),
                  Common.smallSizedBox(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AutoSizeText(
                        'AED ${widget.item.price.toStringAsFixed(2)}',
                        maxLines: 1,
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.primary),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                widget.controller.cartDecrement(
                                  cartItem: widget.item,
                                  id: widget.userId,
                                );
                              },
                              icon: const Icon(Icons.remove),
                            ),
                            Text(
                              '${widget.item.quantity}',
                              style: const TextStyle(fontSize: 16.0),
                            ),
                            IconButton(
                              onPressed: () {
                                widget.controller.cartIncrement(
                                  cartItem: widget.item,
                                  id: widget.userId,
                                );
                              },
                              icon: const Icon(Icons.add),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
