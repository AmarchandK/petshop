import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:petvillage/constant/common_widget.dart';
import 'package:petvillage/screen/orders/model/orders_model.dart';

class OrdersInnerView extends StatefulWidget {
  const OrdersInnerView({super.key, required this.data});
  final MyOrders data;
  @override
  State<OrdersInnerView> createState() => _OrdersInnerViewState();
}

class _OrdersInnerViewState extends State<OrdersInnerView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: const Text(
          "Order Details",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        physics: const BouncingScrollPhysics(),
        children: [
          Common.text(
            text: "Orders Items",
            fontSize: 18,
          ),
          const SizedBox(height: 10),
          ListView.separated(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: widget.data.lineItems?.length ?? 0,
            itemBuilder: (context, index) {
              final data = widget.data.lineItems?[index];
              return Row(
                children: [
                  CachedNetworkImage(
                    imageUrl: data?.image?.src ?? "",
                    height: 70,
                    width: 70,
                    fit: BoxFit.cover,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Center(
                      child: SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          value: downloadProgress.progress,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Common.text(
                      text: data?.name ?? "",
                      fontSize: 16,
                    ),
                  ),
                  Common.text(
                    text: data?.quantity.toString() ?? "",
                    fontSize: 16,
                  ),
                  Common.text(
                    text: data?.total.toString() ?? "",
                    fontSize: 16,
                  ),
                ],
              );
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Common.text(
                  text: "Order Details",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(height: 10),
                oDetail(
                  tittle: "Order Number",
                  value: "#${widget.data.id}",
                ),
                const SizedBox(height: 2),
                const Divider(
                  thickness: .3,
                  height: 1,
                ),
                const SizedBox(height: 4),
                oDetail(
                  tittle: "Order Date",
                  value: DateFormat("dd-MM-yyyy").format(
                    widget.data.dateCreated ?? DateTime.now(),
                  ),
                ),
                const SizedBox(height: 2),
                const Divider(
                  thickness: .3,
                  height: 1,
                ),
                const SizedBox(height: 4),
                oDetail(
                  tittle: "Order Status",
                  value: widget.data.status ?? "",
                ),
                const SizedBox(height: 2),
                const Divider(
                  thickness: .3,
                  height: 1,
                ),
                const SizedBox(height: 4),
                oDetail(
                  tittle: "Payment Method",
                  value: widget.data.paymentMethodTitle ?? "",
                ),
                const SizedBox(height: 2),
                const Divider(
                  thickness: .3,
                  height: 1,
                ),
                const SizedBox(height: 4),
                oDetail(
                  tittle: "Shipping Method",
                  value: widget.data.shippingLines?[0].methodTitle ?? "",
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Row oDetail({String tittle = "", String value = ""}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Common.text(
          text: tittle,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        Common.text(
          text: value,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ],
    );
  }
}
