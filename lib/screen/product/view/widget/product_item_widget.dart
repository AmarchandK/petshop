import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:petvillage/constant/colors_file.dart';
import 'package:petvillage/constant/common_widget.dart';
import 'package:petvillage/constant/responsive.dart';
import 'package:petvillage/screen/home/controller/home_controller.dart';
import 'package:petvillage/screen/home/model/product_model.dart';
import '../../../cart/model/cart_item.dart';
import '../../../product_inner_view/controller/product_inner_view_controller.dart';
import '../../controller/product_controller.dart';

class ProductItemWidget extends StatefulWidget {
  const ProductItemWidget({
    super.key,
    required this.product,
    required this.isFavorite,
  });
  final bool isFavorite;
  final ProductElement product;

  @override
  State<ProductItemWidget> createState() => _ProductItemWidgetState();
}

class _ProductItemWidgetState extends State<ProductItemWidget> {
  final controller = Get.put(ProductController());
  final iController = Get.put(ProductInnerViewController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all(
          color: Colors.grey,
          width: 0.5,
        ),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CachedNetworkImage(
                  imageUrl: widget.product.images?[0].src ?? "",
                  height: 170,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Center(
                    child: SpinKitFadingFour(
                      color: AppColors.primary,
                      size: 50.0,
                    ),
                  ),
                  errorWidget: (context, url, error) => Icon(
                    Icons.hide_image,
                    color: AppColors.greyColor,
                    size: 70,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Flexible(
                child: Common.text(
                  text: widget.product.title ?? "",
                  maxLines: 2,
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Common.text(
              //   text: "${widget.product.regularPrice ?? 0.00} AED",
              //   color: Colors.red,
              //   fontWeight: FontWeight.bold,
              //   isLineThrough: true,
              //   fontSize: 15,
              // ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Common.text(
                          text:
                              "${widget.product.salePrice == 0 || widget.product.salePrice == null ? widget.product.regularPrice : widget.product.salePrice} AED",
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        Common.text(
                          text: "Price Excluding VAT",
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 10,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              widget.product.quantity == 0
                  ? Align(
                      alignment: Alignment.center,
                      child: Common.button(
                        buttonWidth: Responsive.width * 40,
                        buttonColor: AppColors.primary,
                        fontSize: 12,
                        buttonHeight: 40,
                        text: widget.product.inStock == true
                            ? "Add to cart"
                            : "Out of Stock",
                        onPressed: () {
                          if (widget.product.inStock == true) {
                            CartItemModel cartItemModel = CartItemModel(
                              image: widget.product.images?.first.src ?? "",
                              name: widget.product.title ?? "",
                              price: double.tryParse(
                                    widget.product.salePrice == 0 ||
                                            widget.product.salePrice == null
                                        ? widget.product.regularPrice
                                        : widget.product.salePrice ?? "",
                                  ) ??
                                  0,
                              quantity: widget.product.quantity,
                              id: widget.product.id ?? 0,
                            );
                            iController.addToCart(
                              product: cartItemModel,
                              quantity: 1,
                            );
                            setState(() {
                              widget.product.quantity++;
                            });
                          }
                        },
                        radius: 10,
                      ),
                    )
                  : Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.grey,
                          width: 0.5,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              if (widget.product.inStock == true) {
                                CartItemModel cartItemModel = CartItemModel(
                                  image: widget.product.images?.first.src ?? "",
                                  name: widget.product.title ?? "",
                                  price: double.tryParse(
                                        widget.product.salePrice ?? "",
                                      ) ??
                                      0,
                                  quantity: widget.product.quantity,
                                  id: widget.product.id ?? 0,
                                );
                                if (widget.product.quantity > 0) {
                                  log("clicked");
                                  setState(() {
                                    widget.product.quantity--;
                                  });
                                  if (widget.product.quantity == 0) {
                                    iController.deleteCart(
                                      productId: widget.product.id ?? 0,
                                    );
                                    return;
                                  }
                                  iController.addToCart(
                                    product: cartItemModel,
                                    quantity: -1,
                                  );
                                }
                              }
                            },
                            icon: const Icon(
                              Icons.remove,
                              color: Colors.black,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            child: Common.text(
                              text: widget.product.quantity.toString(),
                              fontSize: 18,
                              height: 2,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              CartItemModel cartItemModel = CartItemModel(
                                image: widget.product.images?.first.src ?? "",
                                name: widget.product.title ?? "",
                                price: double.tryParse(
                                      widget.product.salePrice ?? "",
                                    ) ??
                                    0,
                                quantity: widget.product.quantity,
                                id: widget.product.id ?? 0,
                              );
                              iController.addToCart(
                                product: cartItemModel,
                                quantity: 1,
                              );
                              setState(() {
                                widget.product.quantity++;
                              });
                            },
                            icon: const Icon(
                              Icons.add,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    )
            ],
          ),
          Visibility(
            visible: widget.product.inStock == true ? false : true,
            child: Positioned(
              top: 10,
              left: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Common.text(
                    text: "Out of Stock",
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: IconButton(
              onPressed: () {
                controller.addToFavorite(
                  userId: Get.find<HomeController>().userId,
                  data: CartItemModel(
                    id: widget.product.id ?? 0,
                    image: widget.product.images?[0].src ?? "",
                    name: widget.product.title ?? "",
                    price: double.parse(widget.product.price ?? "0.00"),
                    quantity: 1,
                  ),
                );
              },
              icon: Icon(
                widget.isFavorite ? IconlyBold.heart : IconlyLight.heart,
                color: widget.isFavorite
                    ? AppColors.redColor
                    : AppColors.blackColor.withOpacity(0.5),
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
