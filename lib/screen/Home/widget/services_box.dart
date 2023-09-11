import 'package:brush/constant/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class ServiceBox extends StatelessWidget {
  final String serviceName;
  final String servicePrice;
  final String serviceImage;
  final Set<int> selectedIndices;
  final VoidCallback onTap;
  final int index;
  ServiceBox({
    super.key,
    required this.serviceName,
    required this.servicePrice,
    required this.serviceImage,
    required this.selectedIndices,
    required this.onTap,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        height: 55.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.network(serviceImage),
                SizedBox(
                  width: 6.w,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      serviceName,
                      style: TextStyle(fontSize: 16.sp, color: black),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      '$servicePrice ريال',
                      style: TextStyle(
                          fontSize: 14.5.sp, color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ],
            ),
            InkWell(
              onTap: onTap,
              child: Container(
                  height: 25.h,
                  width: 25.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: appColor),
                  ),
                  child: Icon(
                    Icons.check,
                    color: selectedIndices.contains(index)
                        ? appColor
                        : Colors.transparent,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
