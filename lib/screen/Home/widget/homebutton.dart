import 'package:brush/constant/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeButton2 extends StatelessWidget {
  final int price;
  final String date;
  final String time;
  final Function() ontap;
  const HomeButton2(
      {super.key,
      required this.price,
      required this.date,
      required this.time,
      required this.ontap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$price.00 ريال',
              style: TextStyle(fontSize: 16.5.sp, color: black),
            ),
            Row(
              children: [
                Text(
                  date,
                  style:
                      TextStyle(fontSize: 13.5.sp, color: Colors.grey.shade700),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Text(
                  '$time:00',
                  style:
                      TextStyle(fontSize: 13.5.sp, color: Colors.grey.shade700),
                ),
                Text(
                  'م',
                  style:
                      TextStyle(fontSize: 13.5.sp, color: Colors.grey.shade700),
                ),
              ],
            ),
          ],
        ),
        InkWell(
          onTap: ontap,
          child: Container(
            height: 40.h,
            width: 120.w,
            decoration: BoxDecoration(
                color: appColor, borderRadius: BorderRadius.circular(10)),
            child: Center(
                child: Text(
              'التالي',
              style: TextStyle(color: white, fontSize: 17.sp),
            )),
          ),
        ),
      ],
    );
  }
}
