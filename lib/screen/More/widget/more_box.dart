import 'package:brush/constant/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class MoreBox extends StatelessWidget {
  String image;
  String title;
  Function() onTap;
  MoreBox(
      {super.key,
      required this.image,
      required this.title,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 60.h,
        width: 1.sw,
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: appColor.withOpacity(0.1),
                spreadRadius: 0,
                blurRadius: 10,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ]),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            SizedBox(
              width: 20.w,
            ),
            Image.asset(
              image,
              height: 30.h,
              width: 30.w,
            ),
            SizedBox(
              width: 10.w,
            ),
            Text(
              title,
              style: TextStyle(fontSize: 17.sp),
            ),
          ]),
        ),
      ),
    );
  }
}
