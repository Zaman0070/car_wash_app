import 'package:brush/constant/app_image.dart';
import 'package:brush/constant/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GiftBox extends StatelessWidget {
  final String image;
  final String title;
  final String giftCode;
  final int index;
  final int totalLength;
  final Function() onTap;
  const GiftBox(
      {super.key,
      required this.image,
      required this.title,
      required this.giftCode,
      required this.index,
      required this.totalLength,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        decoration: BoxDecoration(
            color: appColor.withOpacity(0.1),
            borderRadius: index == 0
                ? const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  )
                : index == totalLength - 1
                    ? const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      )
                    : BorderRadius.circular(0)),
        child: Padding(
          padding: index == 0
              ? const EdgeInsets.all(12.0)
              : const EdgeInsets.only(left: 12, right: 12, bottom: 12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'كود الهدية',
                    style: TextStyle(
                        letterSpacing: 0, fontSize: 13.sp, color: appColor),
                  ),
                  Text(
                    giftCode,
                    style: TextStyle(
                        letterSpacing: 0, fontSize: 13.sp, color: appColor),
                  )
                ],
              ),
              Row(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 33.h,
                        backgroundImage: AssetImage(image),
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        title,
                        style: TextStyle(
                            letterSpacing: 0,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 85),
                child: AppButton(
                  barder: false,
                  onTap: onTap,
                  text: 'تفاصيل اكثر',
                ),
              ),
              index == totalLength - 1
                  ? Container()
                  : Divider(
                      color: appColor.withOpacity(0.25),
                      thickness: 1,
                    )
            ],
          ),
        ),
      ),
    );
  }
}
