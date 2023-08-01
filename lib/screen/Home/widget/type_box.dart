import 'package:brush/constant/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class TypeBox extends StatelessWidget {
  String image;
  String text;
  Function()? onTap;
  TypeBox({super.key, required this.image, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 85.h,
        width: 1.sw,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: appColor.withOpacity(0.1),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            Image.asset(
             image,
              height: 45.h,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              text,
              style: TextStyle(fontSize: 15.sp, color: appColor),
            )
          ],
        ),
      ),
    );
  }
}
