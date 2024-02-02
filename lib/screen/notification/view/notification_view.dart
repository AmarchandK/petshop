import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';

import '../../../constant/colors_file.dart';
import '../../../constant/common_widget.dart';
import '../../../constant/responsive.dart';
import '../controller/notification_controller.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  final controller = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Common.scaffold<NotificationController>(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        backgroundColor: Colors.white,
        title: Text(
          "Notification",
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
      body: const SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            child: Column(
              children: [
                NotificationItem(),
                NotificationItem(),
                NotificationItem(),
              ],
            )),
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  const NotificationItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColors.primary,
            width: 2,
          )),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Item Ready to Ship',
              style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            Row(
              //mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const CircleAvatar(
                  radius: 5,
                  backgroundColor: Colors.red,
                ),
                SizedBox(
                  width: Responsive.width * 5,
                ),
                const Text(
                  "4 Hours Ago",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                    flex: 1, child: Image.asset('assets/image/cat_food.jpg')),
                const Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.0),
                      child: AutoSizeText(
                        'Your Happy dog mini XS 300g is packed and ready to be shipped',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          //color: AppColors.primary,
                        ),
                      ),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
