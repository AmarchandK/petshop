import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';

import '../../../constant/colors_file.dart';
import '../../../constant/common_widget.dart';
import '../controller/downloads_controller.dart';

class DownloadsView extends StatefulWidget {
  const DownloadsView({super.key});

  @override
  State<DownloadsView> createState() => _DownloadsViewState();
}

class _DownloadsViewState extends State<DownloadsView> {
  final controller = Get.put(DownloadsController());

  @override
  Widget build(BuildContext context) {
    return Common.scaffold<DownloadsController>(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios)),
          backgroundColor: Colors.white,
          title: Text(
            "Downloads",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: AppColors.primary,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                //Navigator.push(context, MaterialPageRoute(builder: (context)=> const ()));
              },
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                    child: Text(
                  'No downloads available yet',
                  textAlign: TextAlign.center,
                )),
                Common.commonOutlinedButton(
                    text: 'Search Products', onTap: () {})
              ],
            ),
          ),
        ));
  }
}
