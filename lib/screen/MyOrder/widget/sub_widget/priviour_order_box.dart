import 'package:brush/constant/app_image.dart';
import 'package:brush/constant/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PiviousOrderBox extends StatelessWidget {
  final String modelname;
  final String plateNumber;
  final String image;
  final String date;
  final String orderNumber;
  final VoidCallback onTap;

  const PiviousOrderBox(
      {super.key,
      required this.modelname,
      required this.plateNumber,
      required this.image,
      required this.date,
      required this.orderNumber,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: appColor.withOpacity(0.05),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.network(image, height: 45.h),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              modelname,
                              style: TextStyle(fontSize: 14.sp, color: black),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Text(
                              'رقم اللوحة    $plateNumber',
                              style: TextStyle(
                                  fontSize: 12.5.sp,
                                  color: Colors.grey.shade400),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          orderNumber,
                          style: TextStyle(fontSize: 8.5.sp, color: appColor),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          date.replaceAll('-', '/'),
                          style: TextStyle(fontSize: 8.5.sp, color: appColor),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: AppButton(
                      onTap: onTap, text: 'تفاصيل اكثر', barder: false),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
