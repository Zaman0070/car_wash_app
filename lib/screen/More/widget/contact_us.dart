import 'package:brush/constant/app_image.dart';
import 'package:brush/screen/More/widget/more_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            'تواصل معنا',
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
            Image.asset('assets/icons/Group 2175.png'),
            SizedBox(
              height: 10.h,
            ),
            MoreBox(
              image: AppImage.whatapp,
              title: 'واتساب',
              onTap: () {
                Get.to(() => const ContactUs());
              },
            ),
            SizedBox(
              height: 10.h,
            ),
            MoreBox(
              image: AppImage.mail,
              title: 'الأيميل',
              onTap: () {},
            ),
            SizedBox(
              height: 10.h,
            ),
            MoreBox(
              image: AppImage.call,
              title: 'اتصال',
              onTap: () {},
            ),
            const Spacer(),
            Text(
              'تابعنا علي',
              style:
                  TextStyle(color: appColor.withOpacity(0.5), fontSize: 18.sp),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 55),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Image.asset(
                      AppImage.tiktok,
                      height: 25.h,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Image.asset(
                      AppImage.insta,
                      height: 25.h,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Image.asset(
                      AppImage.sanpchat,
                      height: 25.h,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Image.asset(
                      AppImage.twitter,
                      height: 25.h,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
