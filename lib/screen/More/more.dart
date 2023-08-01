import 'package:brush/constant/app_image.dart';
import 'package:brush/constant/widget/button.dart';
import 'package:brush/screen/More/widget/about.dart';
import 'package:brush/screen/More/widget/contact_us.dart';
import 'package:brush/screen/More/widget/more_box.dart';
import 'package:brush/screen/auth/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class More extends StatelessWidget {
  const More({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'المزيد',
          style: TextStyle(
            color: black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            MoreBox(
              image: AppImage.user,
              title: 'الحساب',
              onTap: () {},
            ),
            SizedBox(
              height: 10.h,
            ),
            MoreBox(
              image: AppImage.info,
              title: 'عن التطبيق',
              onTap: () {
                Get.to(() => const About());
              },
            ),
            SizedBox(
              height: 10.h,
            ),
            MoreBox(
              image: AppImage.call,
              title: 'تواصل معنا',
              onTap: () {
                Get.to(() => const ContactUs());
              },
            ),
            SizedBox(
              height: 10.h,
            ),
            MoreBox(
              image: AppImage.lock,
              title: 'الشروط والأحكام',
              onTap: () {},
            ),
            SizedBox(
              height: 10.h,
            ),
            MoreBox(
              image: AppImage.language,
              title: 'اعدادات اللغة',
              onTap: () {
                language(context);
              },
            ),
            TextButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Get.offAll(() => Login());
                },
                child: const Text('logout'))
          ],
        ),
      ),
    );
  }

  language(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: ShapeBorder.lerp(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            1,
          ),
          child: Container(
            height: 170.h,
            width: 1.sw,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      Text(
                        'اللغة',
                        style: TextStyle(fontSize: 20.sp, color: appColor),
                      ),
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Image.asset(
                          AppImage.close,
                          height: 22.h,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Column(
                    children: [
                      AppButton(
                          onTap: () {}, text: 'اللغة العربية', barder: false),
                      SizedBox(
                        height: 8.h,
                      ),
                      AppButton(onTap: () {}, text: 'English', barder: true),
                    ],
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
