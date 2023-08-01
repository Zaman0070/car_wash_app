import 'package:brush/constant/app_image.dart';
import 'package:brush/screen/MyOrder/widget/current_add_box.dart';
import 'package:flutter/material.dart';

class CurrentOrder extends StatelessWidget {
  const CurrentOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          CurrentAddBox(
              color: appColor.withOpacity(0.05),
              title: 'لا يوجد طلبات الأن',
              image: AppImage.calender,
              buttonTitle: 'اضف طلب',
              onTap: () {}),
        ],
      ),
    ));
  }
}
