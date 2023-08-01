import 'package:brush/constant/app_image.dart';
import 'package:brush/constant/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class CurrentAddBox extends StatelessWidget {
  Color color;
  final String title;
  final String image;
  final String buttonTitle;
  Function() onTap;
  CurrentAddBox({super.key, required this.color, required this.title, required this.image, required this.buttonTitle, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 245.h,
      width: 1.sw,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color,
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            SizedBox(
              height: 15.h,
            ),
            Image.asset(
              image,
              height: 120.h,
              color: Colors.grey.shade400,
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              title,
              style: TextStyle(
                color: black,
                fontSize: 16.sp,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            AppButton(onTap:onTap, text: buttonTitle, barder: false),
          ],
        ),
      ),
    );
  }
}
