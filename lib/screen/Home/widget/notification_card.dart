import 'package:brush/constant/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationCard extends StatelessWidget {
  final String title;
  final String body;
  final VoidCallback onPressed;
  const NotificationCard(
      {super.key,
      required this.title,
      required this.body,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        width: 1.sw,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: appColor.withOpacity(0.1)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: appColor),
            ),
            SizedBox(height: 5.h),
            Text(
              body,
              style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w400),
            ),
          ]),
        ),
      ),
    );
  }
}
