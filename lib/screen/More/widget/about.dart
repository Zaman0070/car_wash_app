import 'package:brush/constant/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            'من نحن',
            style: TextStyle(color: appColor),
          ),
          centerTitle: true,
          actions: [
            InkWell(
              onTap: () {
                Get.back();
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: Container(
                    width: 28.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: appColor),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: white,
                    )),
              ),
            ),
          ]),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Image.asset('assets/icons/Group 2182.png'),
            SizedBox(
              height: 10.h,
            ),
            Text(
              'عن براش',
              style:
                  TextStyle(color: appColor.withOpacity(0.5), fontSize: 18.sp),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'هذا التطبيق تقوم من خلاله بحجز مغسلة لكي يقوموا بتنظيف العربة الخاصة بك',
              textAlign: TextAlign.center,
              style: TextStyle(color: black, fontSize: 17.sp),
            ),
          ],
        ),
      ),
    );
  }
}
