import 'package:brush/constant/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class HomeButton extends StatelessWidget {
  Function()? onTap;
  String text;
  bool barder;
  HomeButton(
      {Key? key, required this.onTap, required this.text, required this.barder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 43.h,
        width: 100.sw,
        decoration: BoxDecoration(
          border: Border.all(color: appColor),
          borderRadius: BorderRadius.circular(10),
          color: barder == false ? appColor : Colors.transparent,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add,
              color: barder ? appColor : white,
              size: 20.sp,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              text,
              style: TextStyle(
                  color: barder ? appColor : white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
