import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:petvillage/constant/colors_file.dart';
import 'package:petvillage/constant/common_widget.dart';
import 'package:petvillage/constant/routes.dart';
import 'package:petvillage/screen/cart/view/cart_view.dart';
import 'package:petvillage/screen/home/controller/home_controller.dart';
import 'package:petvillage/screen/wishlist/view/wishlist_view.dart';
import '../../product_inner_view/view/product_inner_view.dart';
import '../controller/product_controller.dart';
import 'widget/product_item_widget.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key, required this.tittle});
  final String tittle;
  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  final controller = Get.put(ProductController());
  final double loadMoreThreshold = 300.0;
  bool isLoadingMore = false;
  final scrollController = ScrollController();
  String userId = "";

  @override
  void initState() {
    super.initState();
    userId = Get.find<HomeController>().userId;
    controller.getProductsByCategory();
    scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (!isLoadingMore &&
        scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - loadMoreThreshold) {
      setState(() {
        isLoadingMore = true;
      });
      controller.loadMoreProducts().then((_) {
        setState(() {
          isLoadingMore = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
      builder: (obj) {
        return Common.scaffold<ProductController>(
          isLoading: obj.isLoading,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(widget.tittle),
            centerTitle: false,
            actions: [
              IconButton(
                onPressed: () {
                  Routes.push(
                    screen: const WishListView(),
                    action: (_) {},
                  );
                },
                icon: const Icon(IconlyLight.heart),
              ),
              IconButton(
                onPressed: () {
                  Routes.push(
                    screen: CartView(
                      callback: controller.getProductsByCategory,
                    ),

                    action: (_) {},
                  );
                },
                icon: const Icon(IconlyLight.buy),
              ),
            ],
          ),
          body: obj.products.isEmpty && obj.isLoading == false
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 80,
                      color: AppColors.blackColor,
                    ),
                    Center(
                      child: Text(
                        'No Products Found',
                        style: TextStyle(
                          color: AppColors.blackColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              : StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('favorite')
                      .doc(userId)
                      .snapshots(),
                  builder: (context, snapshot) {
                    return StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('cart')
                            .doc(userId)
                            .collection('items')
                            .snapshots(),
                        builder: (context, cartSnapshot) {
                          List<QueryDocumentSnapshot> fbCart =
                              cartSnapshot.data?.docs ?? [];
                          return GridView.builder(
                            controller: scrollController,
                            padding: Common.kPadding.copyWith(
                              top: 20,
                              bottom: 20,
                              right: 8,
                              left: 8,
                            ),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.55,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemCount:
                                obj.products.length + (isLoadingMore ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (index < obj.products.length) {
                                final product = obj.products[index];

                                bool isFavorite = snapshot.data
                                        ?.data()?["items"]
                                        .firstWhere(
                                            (element) =>
                                                element["id"] == product.id,
                                            orElse: () => false) !=
                                    false;
                                var fbCartitem = fbCart.firstWhereOrNull(
                                    (element) =>
                                        element.id == product.id.toString());
                                var fbCartItemData = fbCartitem?.data() as Map?;
                                double cartItemQty = double.tryParse(
                                        fbCartItemData?['quantity']?.toString()??'0') ??
                                    0;
                                product.quantity = cartItemQty.toInt();
                                return GestureDetector(
                                  onTap: () {
                                    if (product.inStock == false) {
                                      Common.snackBar(
                                        message: "Out of Stock",
                                        title: 'Stock Status',
                                        backgroundColor: AppColors.redColor,
                                      );
                                      return;
                                    }
                                    log("called after go");
                                    Routes.push(
                                      screen: ProductInnerView(
                                        product: product,
                                        isFavorite: isFavorite,
                                      ),
                                      action: (_) {
                                        setState(() {});
                                      },
                                    );
                                  },
                                  child: ProductItemWidget(
                                    product: product,
                                    isFavorite: isFavorite,
                                  ),
                                );
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          );
                        });
                  },
                ),
        );
      },
    );
  }
}
